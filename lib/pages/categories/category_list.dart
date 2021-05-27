import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/pages/categories/filtering_page.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class CategoryListPage extends StatefulWidget {
  final CategoryItem caterory;

  const CategoryListPage({Key key, this.caterory}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionName = 'locations';
  final String _mainField = 'category';
  String _orderBy = 'loves_count';
  List<DocumentSnapshot> _snap = [];
  List<Place> _data = [];
  var _subcategories = <String>[];
  ScrollController _controller;
  DocumentSnapshot _lastVisible;
  bool _isLoading;
  bool _hasData;
  bool _descending = true;
  String _locale;
  String _subField = 'subcategory';
  Map _lastFilters;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasData = true;
    _controller = ScrollController()..addListener(_scrollListener);
    Future.delayed(Duration(microseconds: 20)).then((_) {
      _getData(_locale);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _locale = context.locale.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caterory.name),
        actions: [
          _hasData
              ? IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () async {
                    Map filters = await nextScreenMaterial(
                      context,
                      FilteringPage(
                        category: widget.caterory,
                        filters: _lastFilters,
                      ),
                    );
                    if (filters != null) {
                      setState(() {
                        _subcategories =
                            List<String>.from(filters['subcategories']);
                        _descending = (filters['order_by'] ?? true) as bool;
                        _orderBy =
                            (filters['field'] ?? "loves_count") as String;
                        _lastFilters = filters;
                      });
                      onRefresh();
                    }
                    print(_lastFilters);
                  },
                )
              : IconButton(
                  icon: Icon(Feather.rotate_cw),
                  onPressed: onRefresh,
                )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: !_hasData
            ? ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.32,
                  ),
                  BlankPage(
                    heading: "Nothing found!",
                    shortText: "No places found in this category!",
                    icon: Icons.list_alt_outlined,
                  ),
                ],
              )
            : ListView.separated(
                padding: EdgeInsets.all(15),
                controller: _controller,
                physics: _isLoading
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: _data.length == 0 ? 5 : _data.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _data.length) {
                    return CategoryListItem2(
                      place: _data[index],
                    );
                  }
                  return _isLoading
                      ? Opacity(
                          // opacity: _isLoading ? 1.0 : 0.0,
                          opacity: 1.0,
                          child: _lastVisible == null
                              ? LoadingCard(cardHeight: 150)
                              : Center(
                                  child: SizedBox(
                                    width: 32.0,
                                    height: 32.0,
                                    child: new CircularProgressIndicator(),
                                  ),
                                ),
                        )
                      : Container();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15);
                },
              ),
      ),
      // body: RefreshIndicator(
      //   child: CustomScrollView(
      //     controller: _controller,
      //     slivers: <Widget>[
      //       SliverPadding(
      //         padding: EdgeInsets.all(15),
      //         sliver: SliverList(
      //           delegate: SliverChildBuilderDelegate(
      //             (context, index) {
      //               if (index < _data.length) {
      //                 return CategoryListItem2(
      //                   place: _data[index],
      //                 );
      //               }
      //               return Opacity(
      //                 opacity: _isLoading ? 1.0 : 0.0,
      //                 child: _lastVisible == null
      //                     ? Column(
      //                         children: [
      //                           LoadingCard(cardHeight: 150),
      //                           SizedBox(height: 15)
      //                         ],
      //                       )
      //                     : Center(
      //                         child: SizedBox(
      //                           width: 32.0,
      //                           height: 32.0,
      //                           child: new CircularProgressIndicator(),
      //                         ),
      //                       ),
      //               );
      //             },
      //             childCount: _data.length == 0 ? 5 : _data.length + 1,
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      //   onRefresh: onRefresh,
      // ),
      // body: SafeArea(
      //   child: ListView.separated(
      //     padding: EdgeInsets.all(15),
      //     itemCount: categoryContent.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return CategoryListItem2(
      //         place: categoryContent[index],
      //       );
      //     },
      //     separatorBuilder: (BuildContext context, int index) {
      //       return SizedBox(height: 15);
      //     },
      //   ),
      // ),
    );
  }

  void _scrollListener() {
    if (!_isLoading) {
      // if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() => _isLoading = true);
        _getData(_locale);
      }
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      _snap.clear();
      _data.clear();
      _isLoading = true;
      _lastVisible = null;
    });
    _getData(_locale);
  }

  Future<void> _getData(String locale) async {
    List<Place> places = [];
    QuerySnapshot data;
    setState(() => _hasData = true);
    if (_lastVisible == null) {
      if (_subcategories.isEmpty || _subcategories == null) {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .orderBy(_orderBy, descending: _descending)
            .limit(7)
            .get();
      } else {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .where(_subField, whereIn: _subcategories)
            .orderBy(_orderBy, descending: _descending)
            .limit(7)
            .get();
      }
    } else {
      if (_subcategories.isEmpty || _subcategories == null) {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .orderBy(_orderBy, descending: _descending)
            .startAfterDocument(_lastVisible)
            .limit(7)
            .get();
      } else {
        data = await firestore
            .collection(_collectionName)
            .where(_mainField, isEqualTo: widget.caterory.tag)
            .where(_subField, whereIn: _subcategories)
            .orderBy(_orderBy, descending: _descending)
            .startAfterDocument(_lastVisible)
            .limit(7)
            .get();
      }
    }

    if (data != null && data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        _snap.addAll(data.docs);
        for (var item in _snap) {
          var locRef = item.reference.collection('locales').doc(locale);
          var trData = await locRef.get();
          Place p = Place.fromFirestore(item, locale);
          p.placeTranslation = PlaceTranslation.fromFirebase(trData);
          places.add(p);
        }

        setState(() {
          _data = places;
          // _data.addAll(places);
          _isLoading = false;
        });
      }
    } else {
      // setState(() => _isLoading = false);
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
  }
}

class CategoryListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _cardHeight = 150;
    final double _cardRadius = 5;
    final double _cardImgRadius = 5;

    return InkWell(
      onTap: () {},
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: _cardHeight * 0.9,
            width: _screenWidth,
            margin: EdgeInsets.only(left: 35, top: 25),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(_cardRadius),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 5.0,
              //     spreadRadius: 2.0,
              //     color: Colors.black12,
              //   ),
              // ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: _cardHeight * 0.85 - 10,
                right: 10,
                top: 20,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title with long text content here!",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.grey,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Location with long text content here!",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: 4.3,
                        itemSize: 15,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text("4.3"),
                    ],
                  ),
                  CustomDivider(
                    height: 2,
                    width: 95,
                    margin: EdgeInsets.symmetric(vertical: 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Subcategory text here!",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      statisticsItem(
                        context,
                        LineIcons.heart,
                        "999+",
                        iconColor: Colors.red[600],
                      ),
                      SizedBox(width: 10),
                      statisticsItem(
                        context,
                        LineIcons.comment,
                        "999+",
                        iconColor: Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 5,
            child: Container(
              width: _cardHeight * 0.85,
              height: _cardHeight * 0.85,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(_cardImgRadius),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Center(
                child: Text("IMG"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statisticsItem(BuildContext context, IconData icon, String count,
      {Color iconColor}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
        SizedBox(width: 5),
        Text(
          count,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class CategoryListItem2 extends StatelessWidget {
  final Place place;

  const CategoryListItem2({Key key, @required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _cardHeight = 150;
    final double _cardRadius = 5;
    final double _cardImgRadius = 5;
    final String _tag = '${place.category}${UniqueKey().toString()}';

    return InkWell(
      onTap: () {
        nextScreenMaterial(context, PlaceDetailsPage(tag: _tag, place: place));
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: _cardHeight * 0.9,
            width: _screenWidth,
            margin: EdgeInsets.only(left: 35, top: 25),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(_cardRadius),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 5.0,
              //     spreadRadius: 2.0,
              //     color: Colors.black12,
              //   ),
              // ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: _cardHeight * 0.85 - 10,
                right: 10,
                // top: 20,
                // bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Title with long text content here!",
                    place.placeTranslation.name,
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
                          // "Location with long text content here!",
                          place.region,
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
                  Text(
                    // "Subcategory with some long text here!",
                    place.subcategory,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                  CustomDivider(
                    height: 2,
                    width: _screenWidth * 0.22,
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      statisticsItem(
                        context,
                        LineIcons.star,
                        place.starRating.toString(),
                        iconColor: Colors.amber,
                      ),
                      SizedBox(width: 10),
                      statisticsItem(
                        context,
                        LineIcons.heart,
                        place.loves.toString(),
                        iconColor: Colors.red[600],
                      ),
                      SizedBox(width: 10),
                      statisticsItem(
                        context,
                        LineIcons.comment,
                        place.reviewsCount.toString(),
                        iconColor: Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 5,
            child: HeroWidget(
              tag: _tag,
              child: Container(
                width: _cardHeight * 0.85,
                height: _cardHeight * 0.85,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  // image: DecorationImage(
                  //   // image: NetworkImage(place.gallery[0]),
                  //   // fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.circular(_cardImgRadius),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_cardRadius),
                  child: CustomCachedImage(
                    imageUrl: place.gallery[0],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 10,
          //   left: 5,
          //   child: Container(
          //     width: _cardHeight * 0.85,
          //     height: _cardHeight * 0.85,
          //     decoration: BoxDecoration(
          //       color: Colors.green,
          //       image: DecorationImage(
          //         image: NetworkImage(place.gallery[0]),
          //         fit: BoxFit.cover,
          //       ),
          //       borderRadius: BorderRadius.circular(_cardImgRadius),
          //       boxShadow: [
          //         BoxShadow(
          //           blurRadius: 8.0,
          //           spreadRadius: 1.0,
          //           color: Colors.black12,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget statisticsItem(BuildContext context, IconData icon, String count,
      {Color iconColor}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
        SizedBox(width: 5),
        Text(
          count,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
