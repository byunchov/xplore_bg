import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/models/restaurant.dart';
import 'package:xplore_bg/pages/restaurant_details.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/maps_pin_converter.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class RestaurantsPage extends StatefulWidget {
  final Place place;
  RestaurantsPage({Key key, @required this.place}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage>
    with AutomaticKeepAliveClientMixin<RestaurantsPage> {
  GoogleMapController _controller;
  List<Restaurant> _alldata = [];
  PageController _pageController;
  SwiperController _swiperController;
  bool _animateCamera = true;
  int prevPage;
  List _markers = [];
  Uint8List _customMarkerIcon;
  final String _mapAPIKey = AppConfig().mapsAPIKey;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void openEmptyDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("we didn't find any nearby restaurants in this area"),
            title: Text(
              'no restaurants found',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
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

  Future getData() async {
    String dataUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
            '?location=${widget.place.latitude},${widget.place.longitude}' +
            '&radius=5000&type=restaurant&key=$_mapAPIKey';

    // print(url);

    http.Response response = await http.get(dataUrl);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      if (decodedData['results'].isEmpty) {
        openEmptyDialog();
      } else {
        String thumb;
        for (var i = 0; i < decodedData['results'].length; i++) {
          if (decodedData['results'][i]['photos'] == null) {
            thumb = decodedData['results'][i]['icon'];
          } else {
            thumb = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400' +
                "&photoreference=${decodedData['results'][i]['photos'][0]['photo_reference']}&key=$_mapAPIKey";
          }

          Restaurant restaurant = Restaurant(
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
            // openNow: decodedData['results'][i]['opening_hours'] != null
            //     ? decodedData['results'][i]['opening_hours']['open_now'] ?? true
            //     : false,
          );

          // if()

          _alldata.add(restaurant);
          _alldata.sort((a, b) => b.rating.compareTo(a.rating));
        }
      }
    }
  }

  setMarkerIcon() async {
    _customMarkerIcon =
        await getBytesFromAsset(AppConfig().restaurantPinIcon, 100);
  }

  _addMarker() {
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

              // moveCamera(index);
              // _animateCamera = false;
              _swiperController.move(index);
              // _pageController.animateToPage(
              //   index,
              //   duration: Duration(milliseconds: 1200),
              //   curve: Curves.easeInOutCubic,
              // );
              // prevPage = index;
            },
          ),
        );
      });
    }
  }

  void _onScroll() {
    // int currPage = _pageController.page.toInt();
    int currPage = _swiperController.index;
    print("In _onScroll(): $currPage");
    if (currPage != prevPage) {
      prevPage = currPage;
      if (_animateCamera) {
        // moveCamera();
      }
      _animateCamera = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController()..addListener(_onScroll);

    // _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
    //   ..addListener(_onScroll);
    setMarkerIcon();
    // animateCameraAfterInitialization();
    getData().then((value) {
      // animateCameraAfterInitialization();
      _addMarker();
    });
  }

  _restaurantListItem(BuildContext context, int index) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardHeight = 220;
    double _cardRadius = 10;

    return InkWell(
      onTap: () {
        // _onCardTap(index);
        var id = _alldata[index].id;
        nextScreenMaterial(
          context,
          RestaurantDetailsPage(
            placeId: id,
            tag: id,
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
                      maxLines: 2,
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
                            maxLines: 2,
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

  _restaurantListItem2(BuildContext context, int index) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardHeight = 220;
    double _cardRadius = 10;

    return InkWell(
      onTap: () {
        _onCardTap(index);
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_cardRadius),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: _cardHeight * 0.6 - 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Title with long text content here!",
                    _alldata[index].name,
                    maxLines: 2,
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
                          // "Location with long text content here!",
                          _alldata[index].address,
                          maxLines: 2,
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
          Positioned(
            top: 0,
            left: (_screenWidth - _screenWidth * 0.7) / 6,
            child: Hero(
              tag: _alldata[index].id,
              child: Container(
                width: _screenWidth * 0.7,
                height: _cardHeight * 0.6,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(_cardRadius),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_cardRadius),
                  child: CustomCachedImage(
                    imageUrl: _alldata[index].thumbnail,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _restaurantListItem1(int index) {
    return InkWell(
      onTap: () {
        _onCardTap(index);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey[300], blurRadius: 5),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              height: MediaQuery.of(context).size.height,
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomCachedImage(
                  imageUrl: _alldata[index].thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(height: 10),
                  Text(
                    _alldata[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(height: 3),
                  Text(
                    _alldata[index].address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                  ),
                  Container(height: 5),
                  Row(
                    children: <Widget>[
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _restaurantList(index) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 140.0,
              width: Curves.easeInOut.transform(value) * 350.0,
              child: widget,
            ),
          );
        },
        child: InkWell(
          onTap: () {
            _onCardTap(index);
          },
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey[300], blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCachedImage(
                      imageUrl: _alldata[index].thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(height: 10),
                      Text(
                        _alldata[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(height: 3),
                      Text(
                        _alldata[index].address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                      Container(height: 5),
                      Row(
                        children: <Widget>[
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
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _onCardTap(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      child: CustomCachedImage(
                        imageUrl: _alldata[index].thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                _alldata[index].address,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rating : ${_alldata[index].rating}/5',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.opacity,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              _alldata[index].priceLevel == 0
                                  ? 'Price : Moderate'
                                  : _alldata[index].priceLevel == 1
                                      ? 'Price : Inexpensive'
                                      : _alldata[index].priceLevel == 2
                                          ? 'Price : Moderate'
                                          : _alldata[index].priceLevel == 3
                                              ? 'Price : Expensive'
                                              : 'Price : Very Expensive',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    child: FlatButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                zoom: 15,
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
                        return _restaurantListItem(context, index);
                      },
                      loop: false,
                      viewportFraction: 0.8,
                      scale: 0.98,
                      onIndexChanged: (int ind) {
                        moveCamera(ind);
                      },
                      controller: _swiperController,
                      // pagination: SwiperPagination(),
                    ),
                    // child: PageView.builder(
                    //   controller: _pageController,
                    //   itemCount: _alldata.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return _restaurantList(index);
                    //   },
                  ),
                ),
          Positioned(
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
                        '${widget.place.name} - Nearby Restaurants',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
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

  void mapCreated(controller) {
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

  moveCamera(int index) {
    // int ind = _pageController.page.toInt();
    // int ind = _swiperController.index;
    int ind = index;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_alldata[ind].lat, _alldata[ind].lng),
          zoom: 20,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }
}
