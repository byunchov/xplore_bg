import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';

class PlaceItemSmall extends StatelessWidget {
  final String tag;
  final Place place;

  const PlaceItemSmall({Key key, @required this.place, @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _tag = '$tag${place.timestamp}';
    double _cardRadius = 10;

    return InkWell(
      child: Container(
        // margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.all(7),
        // EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7), //left: 12,
        width: MediaQuery.of(context).size.width * 0.42,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.2,
              blurRadius: 3.5,
            ),
          ],
        ),
        child: Stack(
          children: [
            HeroWidget(
              tag: _tag,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_cardRadius),
                      // image: DecorationImage(
                      //   image: CachedNetworkImageProvider(place.gallery[0]),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_cardRadius),
                      child: CustomCachedImage(imageUrl: place.gallery[0]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black38],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Text(
                  place.placeTranslation.name,
                  // "Bansko",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 15,
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[600].withOpacity(0.9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LineIcons.heart, size: 18, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        place.loves.toString(),
                        // "10",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        nextScreenHero(context, PlaceDetailsPage(tag: _tag, place: place));
      },
    );
  }
}

class PlaceItemSmall2 extends StatelessWidget {
  final String tag;
  final Place place;

  const PlaceItemSmall2({Key key, @required this.place, @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _tag = '$tag${place.name}';
    return InkWell(
      child: Container(
        // margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.all(7),
        // EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7), //left: 12,
        width: MediaQuery.of(context).size.width * 0.36,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Hero(
              tag: _tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1.0,
                        blurRadius: 3.0),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    place.gallery[0],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black38],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Text(
                  place.name,
                  // "Bansko",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    right: 15,
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[600].withOpacity(0.9),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LineIcons.heart, size: 18, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          place.loves.toString(),
                          // "10",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
      onTap: () {
        nextScreenMaterial(context, PlaceDetailsPage(tag: _tag, place: place));
      },
    );
  }
}
