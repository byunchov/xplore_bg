import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';

class PlaceItemState extends StatelessWidget {
  final String tag;
  final Place place;

  const PlaceItemState({Key key, @required this.place, @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _cardRaduis = 5;
    String _tag = '$tag${place.timestamp}';

    return InkWell(
      child: Container(
        // margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 220,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            HeroWidget(
              tag: _tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.circular(_cardRaduis),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2.0,
                        blurRadius: 5.0),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_cardRaduis),
                  child: Image.network(
                    place.gallery[0],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[600].withOpacity(0.9),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LineIcons.heart, size: 18, color: Colors.white),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            place.loves.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[600].withOpacity(0.9),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LineIcons.commenting_o,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            place.reviewsCount.toString(),
                            // "10",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 90,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black54.withOpacity(0.7),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(_cardRaduis),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.placeTranslation.name,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey[500],
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            place.region,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        // nextScreenMaterial(context, PlaceDetailsPage(tag: _tag, place: place));
        nextScreenHero(context, PlaceDetailsPage(tag: _tag, place: place));
      },
    );
  }
}
