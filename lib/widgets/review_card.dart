import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final Widget actionMenu;

  const ReviewCard({
    Key key,
    @required this.review,
    this.actionMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CustomCachedImage(
                    imageUrl: review.profilePicture,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      review.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      review.relativeTimeDescription ?? review.dateAdded,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              actionMenu == null ? Container() : this.actionMenu,
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              RatingBar.builder(
                initialRating: review.rating.toDouble(),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.zero,
                itemSize: 18,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(width: 5),
              Text(review.rating.toString()),
            ],
          ),
          SizedBox(height: 7),
          Text(review.text),
        ],
      ),
    );
  }
}
