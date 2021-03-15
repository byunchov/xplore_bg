import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg/models/place.dart';

class PlaceItemSmall extends StatelessWidget {
  final String tag;
  final Place place;

  const PlaceItemSmall({Key key, @required this.place, @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(left: 12, top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width * 0.36,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Hero(
              tag: '$tag{place.timestamp}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  place.gallery[0],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
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
                    colors: [Colors.transparent, Colors.black87],
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
                        Icon(LineIcons.heart, size: 16, color: Colors.white),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          place.loves.toString(),
                          // "10",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
