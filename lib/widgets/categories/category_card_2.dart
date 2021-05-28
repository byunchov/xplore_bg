import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/hero_widget.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

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
