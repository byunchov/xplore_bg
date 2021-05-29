import 'dart:convert';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:share/share.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xplore_bg/models/gallery.dart';
import 'package:xplore_bg/models/restaurant.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/misc.dart';
import 'package:http/http.dart' as http;
import 'package:xplore_bg/widgets/carousel.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final String tag;
  final String placeId;
  final String locale;

  RestaurantDetailsPage({this.tag, @required this.placeId, this.locale});

  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  Color _statusBarColor = Colors.transparent;
  RestaurantDetails _restaurantDetails;
  String _sharePlaceDetails;
  bool _fetchSuccess = true;

  List<Widget> _infoList;

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      _fillInfoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    _panelHeightOpen = _screenHeight - _statusBarHeight;
    _panelHeightClosed = _screenHeight - 320;

    return Material(
      child: _restaurantDetails == null
          ? _loadingPlaceholder()
          : Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                SlidingUpPanel(
                  maxHeight: _panelHeightOpen,
                  minHeight: _panelHeightClosed,
                  parallaxEnabled: true,
                  parallaxOffset: 0.5,
                  body: _body(),
                  panelBuilder: (sc) => _panel(sc),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(18.0),
                  //     topRight: Radius.circular(18.0)),
                  onPanelSlide: (double pos) => setState(() {
                    if (pos == 1.0) {
                      _statusBarColor = Colors.white;
                    } else if (pos == 0.0) {
                      _statusBarColor = Colors.transparent;
                    }
                  }),
                ),
                // Status bar color
                Positioned(
                  top: 0,
                  child: ClipRRect(
                    child: Container(
                      width: _screenWidth,
                      height: _statusBarHeight,
                      color: _statusBarColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _loadingPlaceholder() {
    return Center(
      child: _fetchSuccess
          ? CircularProgressIndicator()
          : BlankPage(
              heading: "Something went wrong...",
              icon: Icons.error_outline_rounded,
            ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: [
          _header(),
          Expanded(
            child: ListView(
              physics: ScrollPhysics(),
              controller: sc,
              children: [
                _infoSection(),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Text(
                    'reviews',
                    style: Theme.of(context).textTheme.headline5,
                  ).tr(),
                ),
                _reviewSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color, Function callback) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(label),
        ],
      ),
      onTap: callback,
    );
  }

  Widget _body() {
    return Stack(
      children: [
        ImageCarousel(
          tag: widget.tag,
          imgList: _restaurantDetails.gallery,
          autoPlay: false,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: SafeArea(
            child: CircleAvatar(
              // backgroundColor: Theme.of(context).appBarTheme.color,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                icon: Icon(
                  Feather.arrow_left,
                  // color: Colors.grey[850],
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewSection() {
    return _restaurantDetails.reviews.length == 0
        ? BlankPage(
            heading: tr('no_favourites'),
            icon: Feather.star,
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _restaurantDetails.reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return _reviewItem(_restaurantDetails.reviews[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
  }

  Widget _reviewItem(Review review) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: CustomCachedImage(
                  imageUrl: review.profilePicture,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    review.authorName,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    review.relativeTimeDescription,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              RatingBar.builder(
                initialRating: review.rating.toDouble(),
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
                onRatingUpdate: (rating) {},
              ),
              SizedBox(width: 5),
              Text(review.rating.toString()),
            ],
          ),
          SizedBox(height: 7),
          Text(review.text),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    String url = 'https://maps.googleapis.com/maps/api/place/details/json?' +
        'place_id=${widget.placeId}&fields=name,formatted_address,international_phone_number,' +
        'geometry/location,opening_hours/weekday_text,photos,price_level,rating,reviews,' +
        'url,user_ratings_total,website&language=${widget.locale}&key=${AppConfig.mapsAPIKey}';

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      var decodedData = jsonDecode(body);
      var result = decodedData['result'];

      if (result == null) {
        print("Empty result!");
        setState(() {
          _fetchSuccess = false;
        });
      } else {
        var details = RestaurantDetails(
          name: result['name'] ?? "Name",
          address: result['formatted_address'] ?? "",
          phoneNumber: result['international_phone_number'] ?? "",
          lat: result['geometry']['location']['lat'] ?? 0,
          lng: result['geometry']['location']['lng'] ?? 0,
          openingHours: result['opening_hours'] == null
              ? []
              : result['opening_hours']['weekday_text'] ?? [],
          rating: result['rating'] ?? 1.0,
          url: result['url'] ?? "",
          totalRatings: result['user_ratings_total'] ?? 0,
          website: result['website'] ?? "",
        );

        var pl =
            result['price_level'] == null ? -1 : result['price_level'].toInt();
        if (pl == -1) {
          details.priceLevel = '(--)';
        } else if (pl == 0) {
          details.priceLevel = '(Free)';
        } else {
          details.priceLevel = "(${'\$' * pl})";
        }

        List<Gallery> gallery = [];
        Gallery gal;

        if (result['photos'] != null) {
          for (var photo in result['photos']) {
            gal = Gallery(
              author: removeEscapedHtml(
                  removeHtmlTags(photo['html_attributions'][0])),
              imageUrl: 'https://maps.googleapis.com/maps/api/place/photo?' +
                  'maxwidth=1000&photoreference=${photo['photo_reference']}' +
                  '&key=${AppConfig.mapsAPIKey}',
            );
            gallery.add(gal);
          }
        } else {
          gal = Gallery(
            author: "Unsplash",
            imageUrl:
                "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
          );
          gallery.insert(0, gal);
        }

        details.gallery = gallery;

        List<Review> reviews = [];

        if (result['reviews'] != null) {
          Review rev;
          for (var review in result['reviews']) {
            rev = Review(
              authorName: review['author_name'] ?? "Author",
              profilePicture: review['profile_photo_url'] ?? "",
              rating: review['rating'] ?? 1.0,
              relativeTimeDescription:
                  review['relative_time_description'] ?? 'now',
              text: review['text'] ?? "Desctiption",
            );

            reviews.add(rev);
          }
        }
        details.reviews = reviews;

        setState(() {
          _restaurantDetails = details;
          _sharePlaceDetails =
              "${details.name}\n${details.phoneNumber}\n${details.url}";
          _fetchSuccess = true;
        });
      }
    }
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2.0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this._restaurantDetails.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[800]),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: _restaurantDetails.rating.toDouble(),
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
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(width: 5),
                    Text(_restaurantDetails.rating.toString()),
                    SizedBox(width: 5),
                    Text("(${_restaurantDetails.totalRatings})"),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "${tr('tag_restaurant')} · ${_restaurantDetails.priceLevel}",
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection() {
    return Column(
      children: [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _button(
              "Навигиране",
              Icons.directions,
              Colors.blue,
              () async => await canLaunch(_restaurantDetails.url)
                  ? await launch(_restaurantDetails.url)
                  : throw 'Could not launch ${_restaurantDetails.url}',
            ),
            _button(
              "Обади се",
              Icons.phone,
              Colors.green,
              () async => await canLaunch(
                      "tel:${_restaurantDetails.phoneNumber}")
                  ? await launch("tel:${_restaurantDetails.phoneNumber}")
                  : throw 'Could not launch tel:${_restaurantDetails.phoneNumber}',
            ),
            _button(
              "Сподели",
              Icons.share,
              Colors.amber,
              () {
                Share.share(
                  _sharePlaceDetails,
                  subject: _restaurantDetails.name,
                );
              },
            ),
          ],
        ),
        SizedBox(height: 30),
        Divider(),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _infoList.length,
          itemBuilder: (BuildContext context, int index) {
            return _infoList[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
        Divider(),
      ],
    );
  }

  void _fillInfoList() {
    List<Widget> list = [];

    // add place address
    list.add(
      ListTile(
        title: Text(_restaurantDetails.address),
        leading: Icon(Feather.map_pin),
        onTap: () async => await canLaunch(_restaurantDetails.url)
            ? await launch(_restaurantDetails.url)
            : throw 'Could not launch ${_restaurantDetails.url}',
      ),
    );

    // add place phone number
    if (_restaurantDetails.phoneNumber.isNotEmpty) {
      list.add(
        ListTile(
          title: Text(_restaurantDetails.phoneNumber),
          leading: Icon(Icons.phone),
          onTap: () async => await canLaunch(
                  "tel:${_restaurantDetails.phoneNumber}")
              ? await launch("tel:${_restaurantDetails.phoneNumber}")
              : throw 'Could not launch tel:${_restaurantDetails.phoneNumber}',
        ),
      );
    }

    // add place website
    if (_restaurantDetails.website.isNotEmpty) {
      list.add(
        ListTile(
          title: Text(
            _restaurantDetails.website,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: Icon(Icons.language_sharp),
          onTap: () async => await canLaunch(_restaurantDetails.website)
              ? await launch(_restaurantDetails.website)
              : throw 'Could not launch ${_restaurantDetails.website}',
        ),
      );
    }

    if (_restaurantDetails.openingHours.length != 0) {
      list.add(
        ExpansionTile(
          title: Text("opening_hours").tr(),
          leading: Icon(Icons.access_time),
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _restaurantDetails.openingHours.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_restaurantDetails.openingHours[index]),
                );
              },
            ),
          ],
        ),
      );
    }

    setState(() {
      _infoList = list;
    });
  }
}
