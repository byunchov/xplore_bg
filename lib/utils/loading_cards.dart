import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class LoadingCard extends StatelessWidget {
  final double cardHeight;
  const LoadingCard({Key key, @required this.cardHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(3),
          ),
          height: cardHeight,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class SmallLoadingCard extends StatelessWidget {
  final double radius;
  final double width;

  const SmallLoadingCard({
    Key key,
    this.radius = 10,
    @required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      child: SkeletonAnimation(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

class ReviewLoadingCard extends StatelessWidget {
  const ReviewLoadingCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SkeletonAnimation(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonAnimation(
                      child: Container(
                        height: 18,
                        width: _screenWidth * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    SkeletonAnimation(
                      child: Container(
                        height: 14,
                        width: _screenWidth * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          SkeletonAnimation(
            child: Container(
              height: 18,
              width: _screenWidth * 0.35,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(height: 7),
          SkeletonAnimation(
            child: Container(
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(height: 7),
          SkeletonAnimation(
            child: Container(
              width: _screenWidth * 0.85,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(height: 7),
          SkeletonAnimation(
            child: Container(
              width: _screenWidth * 0.65,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryLoadingCard2 extends StatelessWidget {
  const CategoryLoadingCard2({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _cardHeight = 150;
    final double _cardRadius = 5;
    final double _cardImgRadius = 5;
    final _color = Colors.grey[200];

    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: _cardHeight * 0.9,
          width: _screenWidth,
          margin: EdgeInsets.only(left: 35, top: 25),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(_cardRadius),
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
                SkeletonAnimation(
                  child: Container(
                    width: _screenWidth * 0.45,
                    height: 18,
                    color: _color,
                  ),
                ),
                SizedBox(height: 5),
                SkeletonAnimation(
                  child: Container(
                    width: _screenWidth * 0.35,
                    height: 13,
                    color: _color,
                  ),
                ),
                SizedBox(height: 8),
                SkeletonAnimation(
                  child: Container(
                    width: _screenWidth * 0.25,
                    height: 11,
                    color: _color,
                  ),
                ),
                CustomDivider(
                  height: 2,
                  width: _screenWidth * 0.22,
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                ),
                SkeletonAnimation(
                  child: Container(
                    width: _screenWidth * 0.3,
                    height: 18,
                    color: _color,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 5,
          child: SkeletonAnimation(
            child: Container(
              width: _cardHeight * 0.85,
              height: _cardHeight * 0.85,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(_cardImgRadius),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(5, 5),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeaturedLoadingCard extends StatelessWidget {
  const FeaturedLoadingCard({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    final _color = Colors.grey[200];

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Stack(
        children: <Widget>[
          SkeletonAnimation(
            child: Container(
              height: 220,
              width: _screenWidth,
              decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ]),
            ),
          ),
          Positioned(
            height: 120,
            width: _screenWidth * 0.70,
            left: _screenWidth * 0.11,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SkeletonAnimation(
                      child: Container(
                        width: _screenWidth * 0.45,
                        height: 18,
                        color: _color,
                      ),
                    ),
                    SizedBox(height: 7),
                    SkeletonAnimation(
                      child: Container(
                        width: _screenWidth * 0.35,
                        height: 13,
                        color: _color,
                      ),
                    ),
                    CustomDivider(
                      height: 2,
                      width: _screenWidth * 0.22,
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                    ),
                    SkeletonAnimation(
                      child: Container(
                        width: _screenWidth * 0.3,
                        height: 15,
                        color: _color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
