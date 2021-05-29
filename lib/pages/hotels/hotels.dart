import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xplore_bg/models/hotel.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/hotels/hotel_details.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/maps_pin_converter.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

class HotelsPage extends StatefulWidget {
  final Place place;
  final String locale;

  HotelsPage({Key key, @required this.place, this.locale}) : super(key: key);

  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage>
    with AutomaticKeepAliveClientMixin<HotelsPage> {
  GoogleMapController _controller;
  List<Hotel> _alldata = [];
  SwiperController _swiperController;
  int prevPage;
  List _markers = [];
  Uint8List _customMarkerIcon;
  final String _mapAPIKey = AppConfig.mapsAPIKey;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
    setMarkerIcon();
    getData().then((value) {
      _addMarker();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              compassEnabled: false,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.place.latitude, widget.place.longitude),
                zoom: 13.5,
              ),
              markers: Set.from(_markers),
              onMapCreated: mapCreated,
            ),
          ),
          _alldata.isEmpty
              ? Container()
              : Positioned(
                  bottom: 20.0,
                  child: Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(vertical: 20),
                    child: Swiper(
                      itemCount: _alldata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _hotelListItem(context, index);
                      },
                      loop: false,
                      viewportFraction: 0.8,
                      scale: 0.98,
                      onIndexChanged: (int ind) {
                        moveCamera(ind);
                      },
                      controller: _swiperController,
                    ),
                  ),
                ),
          _topNavigation(context),
          _alldata.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    ));
  }

  Widget _topNavigation(BuildContext context) {
    return Positioned(
        top: 15,
        left: 10,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 10,
                          offset: Offset(3, 3))
                    ]),
                child: Icon(Icons.keyboard_backspace),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 10, bottom: 10, right: 15),
                child: Text(
                  "${widget.place.placeTranslation.name} - ${tr('nearby_hotels')}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  Widget _hotelListItem(BuildContext context, int index) {
    // double _screenWidth = MediaQuery.of(context).size.width;
    double _cardHeight = 220;
    double _cardRadius = 10;

    return InkWell(
      onTap: () {
        // _onCardTap(index);
        var id = _alldata[index].id;
        nextScreenMaterial(
          context,
          HotelDetailsPage(
            placeId: id,
            tag: id,
            locale: widget.locale,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 25, left: 6, right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_cardRadius),
          boxShadow: [
            BoxShadow(color: Colors.grey[300], blurRadius: 4.5),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _cardHeight * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_cardRadius),
                  topRight: Radius.circular(_cardRadius),
                ),
                child: CustomCachedImage(
                  imageUrl: _alldata[index].thumbnail,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _alldata[index].name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[850],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            _alldata[index].address,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: _alldata[index].rating.toDouble(),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.zero,
                          itemSize: 18,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        Container(width: 5),
                        Text(
                          '(${_alldata[index].rating})',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dialogNothingFound(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('no_hotels').tr(),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future<void> getData() async {
    String dataUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
            '?location=${widget.place.latitude},${widget.place.longitude}' +
            '&radius=5000&type=hotel&keyword=hotel&language=${widget.locale}&key=$_mapAPIKey';

    http.Response response = await http.get(dataUrl);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      if (decodedData['results'].isEmpty) {
        dialogNothingFound(this.context);
      } else {
        String thumb;
        for (var i = 0; i < decodedData['results'].length; i++) {
          if (decodedData['results'][i]['photos'] == null) {
            thumb = decodedData['results'][i]['icon'];
          } else {
            thumb = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400' +
                "&photoreference=${decodedData['results'][i]['photos'][0]['photo_reference']}&key=$_mapAPIKey";
          }

          Hotel hotel = Hotel(
            id: decodedData['results'][i]['place_id'],
            name: decodedData['results'][i]['name'],
            address: decodedData['results'][i]['vicinity'] ?? '',
            rating: decodedData['results'][i]['rating'] ?? 0.0,
            lat: decodedData['results'][i]['geometry']['location']['lat']
                    .toDouble() ??
                0.0,
            lng: decodedData['results'][i]['geometry']['location']['lng']
                    .toDouble() ??
                0.0,
            priceLevel: decodedData['results'][i]['price_level'] ?? 0,
            thumbnail: thumb,
          );

          _alldata.add(hotel);
          _alldata.sort((a, b) => b.rating.compareTo(a.rating));
        }
      }
    }
  }

  void setMarkerIcon() async {
    _customMarkerIcon = await getBytesFromAsset(AppConfig.hotelPinIcon, 100);
  }

  void _addMarker() {
    for (var data in _alldata) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(data.name),
            position: LatLng(data.lat, data.lng),
            infoWindow: InfoWindow(title: data.name, snippet: data.address),
            icon: BitmapDescriptor.fromBytes(_customMarkerIcon),
            onTap: () {
              int index =
                  _alldata.indexWhere((rest) => rest.id.contains(data.id));
              _swiperController.move(index);
            },
          ),
        );
      });
    }
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  void animateCameraAfterInitialization() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.place.latitude, widget.place.longitude),
          zoom: 13,
        ),
      ),
    );
  }

  void moveCamera(int index) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_alldata[index].lat, _alldata[index].lng),
          zoom: 20,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }
}
