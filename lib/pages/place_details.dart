import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xplore_bg/bloc/bookmark_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/bloc/similar_places_bloc.dart';
import 'package:xplore_bg/models/icon_data.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/restaurants.dart';
import 'package:xplore_bg/pages/reviews/reviews.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/utils/popup_dialogs.dart';
import 'package:xplore_bg/widgets/cards.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';
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

class _PlaceDetailsPageState extends State<PlaceDetailsPage>
    with AutomaticKeepAliveClientMixin {
  Color _statusBarColor = Colors.transparent;

  String _locale;
  String _maptTile;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    double _panelHeightOpen = _screenHeight - _statusBarHeight;
    double _panelHeightClosed = _screenHeight - 320;

    _locale = context.locale.toLanguageTag();
    _maptTile =
        "https://maps.googleapis.com/maps/api/staticmap?center=${widget.place.latitude},${widget.place.longitude}"
        "&zoom=14&size=600x200&scale=2&markers=color:red|${widget.place.latitude},${widget.place.longitude}"
        "&language=$_locale&key=${AppConfig().mapsAPIKey}";

    return Material(
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            body: _body(context),
            panelBuilder: (sc) => _panel(context, sc),
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

  Widget _panelBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ExpandText(
              widget.place.placeTranslation.description ??
                  "No description found!",
              maxLines: 8,
              collapsedHint: tr("show_more"),
              expandedHint: tr("show_less"),
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
          _buildPlaceActivities(context),
          SizedBox(height: 25),

          SimilarPlaces(
            placeId: widget.place.timestamp,
            category: widget.place.categoryTag,
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        HeroWidget(
          tag: widget.tag,
          child: ImageCarousel(
            tag: widget.tag,
            imgList: widget.place.gallery,
            autoPlay: false,
          ),
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

  Widget _header(BuildContext context) {
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
                    widget.place.region,
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
                        widget.place.placeTranslation.name ?? " Name",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[800]),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: widget.place.starRating ?? 0,
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
                            },
                          ),
                          SizedBox(width: 5),
                          Text(widget.place.starRating.toString()),
                        ],
                      ),
                      CustomDivider(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 3,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.place.subcategory} · ${widget.place.category}",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
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
                          icon: ActionIcon(
                            field: 'loved_places',
                            timestamp: widget.place.timestamp,
                            iconStyle: LoveIcon(),
                          ),
                          onPressed: () {
                            handleLoveClick();
                          },
                        ),
                        ActionIconText(
                          field: 'loves_count',
                          timestamp: widget.place.timestamp,
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        IconButton(
                          icon: ActionIcon(
                            field: 'bookmarked_places',
                            timestamp: widget.place.timestamp,
                            iconStyle: BookmarkIcon(),
                          ),
                          onPressed: () {
                            handleBookmarkClick();
                          },
                        ),
                        ActionIconText(
                          field: 'bookmarks_count',
                          timestamp: widget.place.timestamp,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            LineIcons.comments,
                            size: actionIconSize,
                          ),
                          onPressed: () {
                            nextScreenMaterial(
                                context,
                                ReviewsPage(
                                  place: widget.place,
                                ));
                          },
                        ),
                        ActionIconText(
                          field: 'reviews_count',
                          timestamp: widget.place.timestamp,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceActivities(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PlaceActivitiesColorCard(
                  text: tr('nearby_rest'),
                  color: Colors.orange[300],
                  // color: Color(0xffff9e67),
                  callback: () {
                    nextScreenMaterial(
                        context,
                        RestaurantsPage(
                          place: widget.place,
                          locale: _locale,
                        ));
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: PlaceActivitiesColorCard(
                  text: tr('nearby_hotels'),
                  icon: Icons.hotel_rounded,
                  // color: Color(0xff8f9ce2),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          PlaceActivitiesImageCard(
            // text: "Навигация",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: _maptTile,
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

  Widget _panel(BuildContext context, ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              controller: sc,
              child: _panelBody(context),
            ),
          ),
        ],
      ),
    );
  }

  void handleLoveClick() {
    bool _guestUser = context.read<SigninBloc>().guestUser;

    if (_guestUser == true) {
      showLoginDialog(context);
    } else {
      context.read<BookmarkBloc>().onLoveIconClick(widget.place.timestamp);
    }
  }

  void handleBookmarkClick() {
    bool _guestUser = context.read<SigninBloc>().guestUser;

    if (_guestUser == true) {
      showLoginDialog(context);
    } else {
      context.read<BookmarkBloc>().onBookmarkIconClick(widget.place.timestamp);
    }
  }
}

class SimilarPlaces extends StatefulWidget {
  final String category;
  final String placeId;
  const SimilarPlaces({
    Key key,
    @required this.category,
    @required this.placeId,
  }) : super(key: key);

  @override
  _SimilarPlacesState createState() => _SimilarPlacesState();
}

class _SimilarPlacesState extends State<SimilarPlaces> {
  String _locale;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      context
          .read<SimilarPlacesBloc>()
          .fetchData(widget.placeId, widget.category, _locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    _locale = context.locale.toString();
    final bloc = context.watch<SimilarPlacesBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          height: 230,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: bloc.data.isEmpty ? 5 : bloc.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (bloc.data.isEmpty)
                return SmallLoadingCard(
                    width: MediaQuery.of(context).size.width * 0.42);
              return PlaceItemSmall(
                place: bloc.data[index],
                tag: "similar${UniqueKey().toString()}${widget.placeId}",
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 2);
            },
          ),
        ),
      ],
    );
  }
}

class ImageCarousel extends StatelessWidget {
  final double heigth;
  final List<dynamic> imgList;
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
            return ConstrainedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            );
          }),
        ),
        // control: SwiperControl(
        //   color: Colors.white,
        //   padding: EdgeInsets.all(20),
        // ),
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  final String field;
  // final String uid;
  final String timestamp;
  final dynamic iconStyle;

  const ActionIcon({
    Key key,
    @required this.field,
    // @required this.uid,
    @required this.timestamp,
    @required this.iconStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final sb = context.watch<SigninBloc>();

    if (sb.isSignedIn == false) return this.iconStyle.normal;
    return StreamBuilder(
      stream: firestore.collection('users').doc(sb.uid).snapshots(),
      builder: (context, snap) {
        if (sb.uid == null) return this.iconStyle.normal;
        if (!snap.hasData) return this.iconStyle.normal;
        List data = snap.data[field];

        if (data.contains(timestamp)) {
          return this.iconStyle.bold;
        } else {
          return this.iconStyle.normal;
        }
      },
    );
  }
}

class ActionIconText extends StatelessWidget {
  final String field;
  final String timestamp;

  const ActionIconText({
    Key key,
    @required this.field,
    @required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final sb = context.watch<SigninBloc>();

    return StreamBuilder(
      stream: firestore.collection('locations').doc(this.timestamp).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return Text('na');
        int data = snap.data[this.field] as int;
        return Text(data.toString());
      },
    );
  }
}
