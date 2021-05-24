import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/pages/reviews/add_review.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/review_card.dart';

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Review _review = Review(
      authorName: "Me",
      text: "Content",
      rating: 4.2,
      relativeTimeDescription: "20.02.2021",
      profilePicture: AppConfig().defaultProfilePic,
    );

    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("reviews").tr(),
        actions: [
          IconButton(
            icon: Icon(Feather.rotate_ccw),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: [
          _addReview(context),
          // _displayUserReview(context, _review),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              'reviews',
              style: Theme.of(context).textTheme.headline5,
            ).tr(),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ReviewCard(review: _review);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ],
      ),
    );
  }

  Widget _displayUserReview(BuildContext context, Review review) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: ReviewCard(
        review: review,
        actionMenu: _reviewActions(),
      ),
    );
  }

  Widget _reviewActions() {
    return PopupMenuButton(
      child: Center(child: Icon(Icons.more_vert_rounded)),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Feather.edit),
              title: Text("Edit"),
            ),
            value: "edit",
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Feather.delete),
              title: Text("Delete"),
            ),
            value: "delete",
          ),
        ];
      },
      onSelected: (select) {
        print(select);
      },
    );
  }

  Widget _addReview(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rate and review",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 5),
          Text(
            "Share your experience to help others. Be kind and don't swear in the review.",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ClipOval(
                child: Container(
                  height: 60,
                  width: 60,
                  child: CustomCachedImage(
                    imageUrl: AppConfig().defaultProfilePic,
                  ),
                ),
              ),
              SizedBox(width: 5),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: false,
                glowColor: Colors.amber[300],
                itemPadding: EdgeInsets.symmetric(horizontal: 10),
                itemSize: 36,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print("User gave $rating");
                  nextScreenMaterial(
                    context,
                    AddReviewPage(rating: rating),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
