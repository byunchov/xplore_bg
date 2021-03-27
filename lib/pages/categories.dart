import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CategotiesTab extends StatelessWidget {
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

class CategoryCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final double cardRadius;
  final double categotyIconCircle;
  final String title;
  final IconData icon;
  final dynamic image;

  const CategoryCard({
    Key key,
    @required this.cardHeight,
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
            height: cardHeight,
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
              padding: const EdgeInsets.only(left: 20, bottom: 20),
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
