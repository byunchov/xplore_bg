import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/feautured_bloc.dart';
import 'package:xplore_bg/bloc/popular_places_bloc.dart';
import 'package:xplore_bg/bloc/recent_places_bloc.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/pages/show_more.page.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/widgets/featured_widget.dart';
import 'package:xplore_bg/widgets/header.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';
import 'package:xplore_bg/widgets/place_item_small.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  String _locale;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      context.read<FeaturedBloc>().fetchData();
      context.read<PopularPlacesBloc>().fetchData(_locale);
      context.read<RecentlyAddedPlacesBloc>().fetchData(_locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _locale = context.locale.toString() ?? 'bg';
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 20,
      //   title: const Text('Xplore Bulgaria'),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              FeaturedPlaces(),
              SizedBox(height: 5),
              FlatButton(
                onPressed: () {
                  context.read<FeaturedBloc>().fetchData();
                },
                child: Text("Refresh data!"),
              ),
              SizedBox(height: 5),
              PopularPlaces(
                cardHeight: 250,
                sectionHeader: tr('most_popular'),
                onHeaderClick: () {
                  nextScreenMaterial(
                      context,
                      ShowMorePage(
                        page: "popular",
                        title: tr('most_popular'),
                      ));
                },
              ),
              RecentlyAddedPlaces(
                cardHeight: 220,
                sectionHeader: tr('recently_added'),
                onHeaderClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularPlaces extends StatelessWidget {
  final double cardHeight;
  final String sectionHeader;
  final Function onHeaderClick;

  const PopularPlaces({
    Key key,
    this.cardHeight = 250,
    @required this.sectionHeader,
    @required this.onHeaderClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PopularPlacesBloc>();
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    this.sectionHeader,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Feather.arrow_right,
                      color: Colors.grey[800],
                    ),
                    onPressed: this.onHeaderClick,
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: this.cardHeight,
              width: MediaQuery.of(context).size.width,
              // color: Colors.lightBlue,
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
                    tag: "popular",
                    place: bloc.data[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RecentlyAddedPlaces extends StatelessWidget {
  final double cardHeight;
  final String sectionHeader;
  final Function onHeaderClick;

  const RecentlyAddedPlaces({
    Key key,
    this.cardHeight = 250,
    @required this.sectionHeader,
    @required this.onHeaderClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<RecentlyAddedPlacesBloc>();
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    this.sectionHeader,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Feather.arrow_right,
                      color: Colors.grey[800],
                    ),
                    onPressed: this.onHeaderClick,
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: this.cardHeight,
              width: MediaQuery.of(context).size.width,
              // color: Colors.lightBlue,
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
                    tag: "popular",
                    place: bloc.data[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EditorsChoice extends StatelessWidget {
  final Place place;

  const EditorsChoice({
    Key key,
    this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: InkWell(
        child: Stack(
          children: <Widget>[
            HeroWidget(
              tag: 'featured${this.place.timestamp}',
              child: Container(
                height: 220,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    // border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedImage(imageUrl: this.place.gallery[0]),
                ),
              ),
            ),
            Positioned(
              height: 120,
              width: width * 0.70,
              left: width * 0.11,
              bottom: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0, 2),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        // "Title with long text content here!",
                        place.placeTranslation.name ?? "name",
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[850],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(width: 2.5),
                          Expanded(
                            child: Text(
                              // "Location with long text content here!",
                              place.region ?? "region",
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
                      CustomDivider(
                          height: 2,
                          width: width * 0.25,
                          margin: EdgeInsets.symmetric(vertical: 10)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            statisticsItem(
                              context,
                              LineIcons.star,
                              this.place.starRating.toString(),
                              iconColor: Colors.amber,
                            ),
                            SizedBox(width: 10),
                            statisticsItem(
                              context,
                              LineIcons.heart,
                              this.place.loves.toString(),
                              iconColor: Colors.red[600],
                            ),
                            SizedBox(width: 10),
                            statisticsItem(
                              context,
                              LineIcons.comment,
                              this.place.reviewsCount.toString(),
                              iconColor: Colors.blueGrey,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          nextScreenHero(
              context,
              PlaceDetailsPage(
                tag: "featured${this.place.timestamp}",
                place: place,
              ));
        },
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
