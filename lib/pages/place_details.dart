import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/models/restaurant.dart';
import 'package:xplore_bg/pages/categories.dart';
import 'package:xplore_bg/pages/restaurants.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/widgets/cards.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expand_widget/expand_widget.dart';

class PlaceDetailsPage extends StatefulWidget {
  final String tag;
  final Place place;

  PlaceDetailsPage({this.tag, @required this.place});

  @override
  _PlaceDetailsPageState createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState2 extends State<PlaceDetailsPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final List<Place> listSimilar = [
    Place(
      name: 'Банско - Ски писта "Кулиното"',
      loves: 100,
      gallery: <String>[
        "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
      ],
    ),
    Place(
      name: "Разлог",
      loves: 89,
      gallery: <String>[
        "http://infomreja.bg/upload/articles/images/18387/024ec2c710680539c9257aa4a27fd7d5.jpg",
      ],
    ),
    Place(
      name: "Добринище",
      loves: 54,
      gallery: <String>[
        "https://visit-dobrinishte.bg/images/slider/sl1.jpg",
      ],
    ),
    Place(
      name: "Баня",
      loves: 61,
      gallery: <String>[
        "https://rimskabania.com/wp-content/uploads/2016/03/Old_Roman_01.jpg",
      ],
    ),
    // SizedBox(width: 12),
  ];

  double _rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                ImageCarousel(
                    tag: widget.tag, imgList: imgList, autoPlay: false),
                Positioned(
                  top: 20,
                  left: 20,
                  child: SafeArea(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).appBarTheme.color,
                      child: IconButton(
                        icon: Icon(
                          Feather.arrow_left,
                          color: Colors.grey[850],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: DynamicHeader(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ExpandText(
                          '''Крепостта Царевец е синоним на величие, слава и богатство! Това е уникално място за среща с миналото на България и историята на нейните велики царе, които привличат десетки хиляди туристи всяка година. Крепостта се намира на едноименния хълм в старата част на Велико Търново, недалеч от центъра, и е превърната в архитектурно-музеен резерват.

Ако искате да се почувствате като истински царе и принцеси, това е мястото! Още на входа ще имате възможност да се преобразите с царски одежди или рицарски доспехи. Всеки желаещ ще получи и снимка с величествения си лик. Услугата се заплаща.''',
                          maxLines: 8,
                          collapsedHint: "Show more",
                          expandedHint: "Show less",
                          expandArrowStyle: ExpandArrowStyle.both,
                          textAlign: TextAlign.justify,
                          arrowSize: 25,
                          arrowColor: Theme.of(context).primaryColor,
                          arrowPadding: EdgeInsets.only(top: 5),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                          ),
                          hintTextStyle: TextStyle(
                            // fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      // SizedBox(height: 30),
                      Text(
                        "To Do",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      CustomDivider(
                        width: 50,
                        height: 3,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      Text("What you can do here......"),
                      SizedBox(height: 30),
                      Text(
                        "You may also like",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      CustomDivider(
                        width: 120,
                        height: 3,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            // return (index == listSimilar.length)
                            //     ? SizedBox(width: 15)
                            //     : PlaceItemSmall(
                            //         place: listSimilar[index],
                            //         tag: "similar",
                            //       );
                            return PlaceItemSmall(
                              place: listSimilar[index],
                              tag: "similar",
                            );
                          },
                          itemCount: listSimilar.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicHeader extends SliverPersistentHeaderDelegate {
  @override
  // TODO: implement maxExtent
  double get maxExtent => 170;

  @override
  // TODO: implement minExtent
  double get minExtent => 95;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate _) => false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        (maxExtent - minExtent - shrinkOffset) / (maxExtent - minExtent);
    bool _switch = false;
    if (percent <= 0.60) {
      if (!_switch) {
        _switch = true;
        print("_switch value is: $_switch");
      }
    }

    print("Sliver percent: $percent | $shrinkOffset");
    return StatefulBuilder(
      builder: (ctx, setState) {
        bool hideLocation = false,
            hideRating = false,
            hideCategory = false,
            hideStats = false;
        double _rating = 4.8;
        return Container(
          key: UniqueKey(),
          height: (maxExtent - shrinkOffset + minExtent),
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
          child: DelayedDisplay(
            delay: Duration(milliseconds: 0),
            fadingDuration: Duration(milliseconds: 400),
            slidingCurve: Curves.linear,
            child: (percent >= 0.99)
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "Някъде по света",
                                // "location with some fery long and useless description here XD.",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    "Place with long name and history",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey[800]),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: _rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        // ignoreGestures: true,
                                        itemPadding: EdgeInsets.zero,
                                        itemSize: 18,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Text(_rating.toString()),
                                    ],
                                  ),
                                  CustomDivider(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 3,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  Text(
                                    "Крепости и руини",
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Feather.heart,
                                        size: 21,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Text("999+"),
                                  ],
                                ),
                                SizedBox(width: 5),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Feather.bookmark,
                                        size: 21,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Text("999+"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        LineIcons.comments,
                                        size: 21,
                                      ),
                                      onPressed: () {},
                                    ),
                                    Text("999+"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 35, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Place with long name and history",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey[800]),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Feather.heart,
                                size: 21,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(
                                Feather.bookmark,
                                size: 21,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(
                                LineIcons.comments,
                                size: 21,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  double _rating;

  @override
  Widget build(BuildContext context) {
    _rating = widget.place.starRating;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageCarousel(
                  tag: widget.tag,
                  imgList: widget.place.gallery,
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
            ),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            // "Някъде по света",
                            // "location with some fery long and useless description here XD.",
                            widget.place.location,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                // "Place with long name and history",
                                widget.place.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey[800]),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: _rating,
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
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                      setState(() {
                                        _rating = rating;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(_rating.toString()),
                                ],
                              ),
                              CustomDivider(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 3,
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              Text(
                                // "Крепости и руини",
                                widget.place.subcategory,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Feather.heart,
                                    size: 21,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(widget.place.loves.toString()),
                              ],
                            ),
                            SizedBox(width: 5),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Feather.bookmark,
                                    size: 21,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(widget.place.loves.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    LineIcons.comments,
                                    size: 21,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(widget.place.commentCount.toString()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ExpandText(
                      '''Крепостта Царевец е синоним на величие, слава и богатство! Това е уникално място за среща с миналото на България и историята на нейните велики царе, които привличат десетки хиляди туристи всяка година. Крепостта се намира на едноименния хълм в старата част на Велико Търново, недалеч от центъра, и е превърната в архитектурно-музеен резерват.

Ако искате да се почувствате като истински царе и принцеси, това е мястото! Още на входа ще имате възможност да се преобразите с царски одежди или рицарски доспехи. Всеки желаещ ще получи и снимка с величествения си лик. Услугата се заплаща.''',
                      maxLines: 8,
                      collapsedHint: "Show more",
                      expandedHint: "Show less",
                      expandArrowStyle: ExpandArrowStyle.both,
                      textAlign: TextAlign.justify,
                      arrowSize: 25,
                      arrowColor: Theme.of(context).primaryColor,
                      arrowPadding: EdgeInsets.only(top: 5),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800],
                      ),
                      hintTextStyle: TextStyle(
                        // fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Дейности",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  CustomDivider(
                    width: 80,
                    height: 3,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                  ),
                  buildPlaceActivities(),
                  SizedBox(height: 25),
                  Text(
                    "Може да харесате",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  CustomDivider(
                    width: 120,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        // return (index == listSimilar.length)
                        //     ? SizedBox(width: 15)
                        //     : PlaceItemSmall(
                        //         place: listSimilar[index],
                        //         tag: "similar",
                        //       );
                        return PlaceItemSmall(
                          place: categoryContent[index],
                          tag: "similar${UniqueKey().toString()}$index",
                        );
                      },
                      itemCount: categoryContent.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceActivities() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PlaceActivitiesColorCard(
                  text: "Ресторанти",
                  color: Colors.yellow[600],
                  callback: () {
                    nextScreenMaterial(
                        context, RestaurantsPage(place: widget.place));
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: PlaceActivitiesColorCard(
                  text: "Хотели",
                  icon: Icons.hotel_rounded,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          PlaceActivitiesImageCard(
            // text: "Навигация",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: categoryContent[1].gallery[0],
              fit: BoxFit.cover,
            ),
            callback: () {
              print("Location clicked");
            },
          ),
        ],
      ),
    );
  }
}

class ImageCarousel extends StatelessWidget {
  final double heigth;
  final List<String> imgList;
  final bool autoPlay;
  final String tag;

  const ImageCarousel({
    Key key,
    @required this.imgList,
    this.heigth = 320,
    this.autoPlay = false,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.heigth,
      child: Hero(
        tag: this.tag,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CustomCachedImage(
              imageUrl: imgList[index],
              fit: BoxFit.fill,
            );
            // return Image.network(
            //   imgList[index],
            //   fit: BoxFit.fill,
            // );
          },
          autoplay: this.autoPlay,
          itemCount: imgList.length,
          pagination: SwiperPagination(
            alignment: Alignment.bottomLeft,
            builder: SwiperCustomPagination(builder: (context, config) {
              return DelayedDisplay(
                delay: Duration(milliseconds: 200),
                fadingDuration: Duration(milliseconds: 300),
                child: ConstrainedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.55),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Unsplash ${config.activeIndex}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.8),
                            ),
                            child: FractionPaginationBuilder(
                                    color: Colors.white70,
                                    activeColor: Colors.white,
                                    fontSize: 17.0,
                                    activeFontSize: 22.0)
                                .build(context, config),
                          ),
                        ),
                      )
                    ],
                  ),
                  constraints: BoxConstraints.expand(height: 50.0),
                ),
              );
            }),
          ),
          // control: SwiperControl(
          //   color: Colors.white,
          //   padding: EdgeInsets.all(20),
          // ),
        ),
      ),
    );
  }
}

class PlaceActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}
