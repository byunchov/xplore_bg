import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

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
