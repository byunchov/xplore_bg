import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/pages/categories/filtering_page.dart';
import 'package:xplore_bg/pages/place_details.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/place_list.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class CategoryListPage extends StatefulWidget {
  final Category caterory;

  const CategoryListPage({Key key, this.caterory}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caterory.name),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              nextScreenMaterial(context, FilteringPage());
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.all(15),
          itemCount: categoryContent.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryListItem2(
              place: categoryContent[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 15);
          },
        ),
      ),
    );
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
    final String _tag = '${place.category}${place.name}';

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
                    place.name,
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
            child: Hero(
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
