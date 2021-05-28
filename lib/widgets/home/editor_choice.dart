import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

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
