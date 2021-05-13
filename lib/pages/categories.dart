import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xplore_bg/models/category_tile.dart';
import 'package:xplore_bg/pages/categories/category_list.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

class CategotiesTab extends StatefulWidget {
  @override
  _CategotiesTabState createState() => _CategotiesTabState();
}

class _CategotiesTabState extends State<CategotiesTab>
    with AutomaticKeepAliveClientMixin<CategotiesTab> {
  int rand(int min, int max) {
    return (Random().nextInt(max - min) + min);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Category> categoryList = List.generate(
      10,
      (int index) => Category(
        itemCount: rand(10, 1500),
        name: "Category $index",
      ),
    );

    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(20),
      crossAxisCount: 2,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          categoryItem: categoryList[index],
        );
      },
      staggeredTileBuilder: (int index) {
        // return tileList[index];
        if (index == (categoryList.length - 1)) {
          if (index % 2 == 0 || (index % 3 == 0)) {
            return StaggeredTile.count(1, 1);
          } else {
            return StaggeredTile.count(2, 1);
          }
        }
        if (index == 0) {
          return StaggeredTile.count(2, 1);
        } else if (index % 2 == 0 && !(index % 3 == 0)) {
          return StaggeredTile.count(1, 2);
        } else {
          return StaggeredTile.count(1, 1);
        }
      },
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }
}

/*
class CategotiesTabOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _cardRadius = 10;
    final double _cardHeight = 150;
    final double _categotyIconCircle = 45;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CategoryCard(
              cardHeight: _cardHeight,
              cardRadius: _cardRadius,
              title: "Природни забележителности",
              categotyIconCircle: _categotyIconCircle,
              icon: FontAwesome5Solid.mountain,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryCard(
                        cardHeight: _cardHeight,
                        cardRadius: _cardRadius,
                        title: "Култура и изкуство",
                        categotyIconCircle: _categotyIconCircle,
                        icon: FontAwesome5Solid.theater_masks,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight * 1.5,
                        cardRadius: _cardRadius,
                        title: "Маршрути и екопътеки",
                        categotyIconCircle: _categotyIconCircle,
                        icon: FontAwesome5Solid.walking,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight,
                        cardRadius: _cardRadius,
                        title: "Забавления",
                        categotyIconCircle: _categotyIconCircle,
                        icon: FontAwesome5Solid.feather,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight * 1.5,
                        cardRadius: _cardRadius,
                        title: "Сгради и архитектура",
                        categotyIconCircle: _categotyIconCircle,
                        icon: FontAwesome5Solid.building,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryCard(
                        cardHeight: _cardHeight * 1.5,
                        cardRadius: _cardRadius,
                        title: "Култура и изкуство",
                        categotyIconCircle: _categotyIconCircle,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight,
                        cardRadius: _cardRadius,
                        title: "Култура и изкуство",
                        categotyIconCircle: _categotyIconCircle,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight * 1.5,
                        cardRadius: _cardRadius,
                        title: "Култура и изкуство",
                        categotyIconCircle: _categotyIconCircle,
                      ),
                      SizedBox(height: 15),
                      CategoryCard(
                        cardHeight: _cardHeight,
                        cardRadius: _cardRadius,
                        title: "Култура и изкуство",
                        categotyIconCircle: _categotyIconCircle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

class CategoryCard extends StatelessWidget {
  final Category categoryItem;
  final dynamic image;
  final double cardRadius;

  const CategoryCard({
    Key key,
    this.image,
    this.categoryItem,
    this.cardRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              image: DecorationImage(
                image: image ??
                    AssetImage("assets/images/categories/mountain.jpg"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2.0,
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius ?? 5),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black.withOpacity(0.65),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[600].withOpacity(0.9),
                ),
                child: Text(
                  categoryItem.itemCount.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                categoryItem.name,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        nextScreenMaterial(context, CategoryListPage(caterory: categoryItem));
      },
    );
  }
}

class CategoryCardOld extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final double cardRadius;
  final double categotyIconCircle;
  final String title;
  final IconData icon;
  final dynamic image;

  const CategoryCardOld({
    Key key,
    this.cardHeight,
    this.cardWidth,
    this.cardRadius,
    @required this.categotyIconCircle,
    @required this.title,
    this.icon,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            // width: cardWidth ?? MediaQuery.of(context).size.width * 0.5,
            // height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              image: DecorationImage(
                image: image ??
                    AssetImage("assets/images/categories/mountain.jpg"),
                fit: BoxFit.cover,
              ),
              // color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2.0,
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
          Container(
            // width: cardWidth ?? MediaQuery.of(context).size.width * 0.5,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius ?? 5),
              gradient: LinearGradient(
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black.withOpacity(0.75),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                width: categotyIconCircle,
                height: categotyIconCircle,
                child: Icon(
                  icon ?? Icons.image,
                  size: categotyIconCircle * 0.44,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(categotyIconCircle),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              // padding: const EdgeInsets.only(left: 20, bottom: 20),
              padding: EdgeInsets.all(20),
              child: Text(
                this.title,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
