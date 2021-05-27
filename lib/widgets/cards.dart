import 'package:flutter/material.dart';

class PlaceActivitiesColorCard extends StatelessWidget {
  final dynamic text;
  final IconData icon;
  final Color color;
  final double cardHeight;
  final double cardRadius;
  final Function callback;

  const PlaceActivitiesColorCard({
    Key key,
    this.text,
    this.icon,
    this.color,
    this.cardHeight,
    this.cardRadius = 10,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: this.cardHeight ?? 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardRadius),
                color: this.color ?? Colors.blueAccent[400],
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     spreadRadius: 2.0,
                //     blurRadius: 8.0,
                //   ),
                // ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child:
                      Center(child: Icon(this.icon ?? Icons.restaurant_menu)),
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
                  this.text,
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
      ),
      onTap: this.callback ?? () {},
    );
  }
}

class PlaceActivitiesImageCard extends StatelessWidget {
  final dynamic text;
  final IconData icon;
  final Widget image;
  final double cardHeight;
  final double cardRadius;
  final Function callback;

  const PlaceActivitiesImageCard({
    Key key,
    this.text,
    @required this.icon,
    @required this.image,
    this.cardHeight,
    this.cardRadius = 10,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: this.cardHeight ?? 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardRadius),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     spreadRadius: 2.0,
                //     blurRadius: 8.0,
                //   ),
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: this.image,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child:
                      Center(child: Icon(this.icon ?? Icons.restaurant_menu)),
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
                  this.text ?? "",
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
      ),
      onTap: this.callback ?? () {},
    );
  }
}
