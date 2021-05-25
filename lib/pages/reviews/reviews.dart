import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/review_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/pages/blank_page.dart';
import 'package:xplore_bg/pages/reviews/add_review.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/loading_cards.dart';
import 'package:xplore_bg/utils/misc.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/popup_dialogs.dart';
import 'package:xplore_bg/widgets/review_card.dart';

class ReviewsPage extends StatefulWidget {
  final Place place;

  const ReviewsPage({Key key, @required this.place}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final firestore = FirebaseFirestore.instance;
  final _collectionPlaces = 'locations';

  ScrollController _scrollController;
  DocumentSnapshot _lastVisible;
  bool _isLoading, _hasData;
  List<DocumentSnapshot> _snapshots = [];
  List<Review> _reviews = [];
  String _uid;
  Review _userReview;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    _uid = context.read<SigninBloc>().uid;
    _isLoading = true;
    print("Reviews page: UID is $_uid");
    super.initState();
    _getCurrentUserReview();
    _getReviews();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("reviews").tr(),
        actions: [
          IconButton(
            icon: Icon(Feather.rotate_ccw),
            onPressed: () {
              onRefresh();
              // setState(() {
              //   _isLoading = true;
              //   _hasData = true;
              //   _lastVisible = null;
              // });
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: !_hasData
                      ? ListView(
                          children: [
                            _reviewHeader(context),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2),
                            BlankPage(
                              heading: "No Reviews",
                              shortText: "Be the first to comment",
                              icon: Icons.rate_review_rounded,
                            ),
                          ],
                        )
                      : ListView(
                          controller: _scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            _lastVisible == null
                                ? _reviewHeaderLoading()
                                : _reviewHeader(context),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Text(
                                'reviews',
                                style: Theme.of(context).textTheme.headline5,
                              ).tr(),
                            ),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  _reviews.length != 0 ? _reviews.length : 5,
                              itemBuilder: (_, int index) {
                                if (index < _reviews.length) {
                                  return ReviewCard(
                                    review: _reviews[index],
                                    actionMenu: _reviews[index].uid == _uid &&
                                            _uid != null
                                        ? _reviewActions(context)
                                        : Container(),
                                  );
                                }
                                return Opacity(
                                  opacity: _isLoading ? 1.0 : 0.0,
                                  child: _lastVisible == null
                                      // ? LoadingCard(cardHeight: 160)
                                      ? ReviewLoadingCard()
                                      : Center(
                                          child: SizedBox(
                                            width: 32.0,
                                            height: 32.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _reviewHeader(BuildContext context) {
    final sb = context.read<SigninBloc>();
    if (sb.guestUser) {
      return _notSignedIn(context);
    } else {
      return _userReview == null
          ? _addReview(context)
          : _displayUserReview(context, _userReview);
    }
  }

  Widget _notSignedIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            "Not logged in!\nLogin to gie review.",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          ElevatedButton(
              child: Text("Log in".toUpperCase()),
              style: ElevatedButton.styleFrom(
                  elevation: 3,
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () {
                nextScreenMaterial(context, LoginScreen());
              }),
        ],
      ),
    );
  }

  Widget _reviewHeaderLoading() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      color: Colors.grey[100],
      child: ReviewLoadingCard(),
    );
  }

  Widget _displayUserReview(BuildContext context, Review review) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: ReviewCard(
        review: review,
        actionMenu: _reviewActions(context),
      ),
    );
  }

  Widget _reviewActions(BuildContext context) {
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
      onSelected: (select) async {
        if (select == 'delete') {
          _handleDelete(context);
        } else if (select == 'edit') {
          final result = await nextScreenMaterial(
            context,
            AddReviewPage(
              place: this.widget.place,
              review: _userReview,
            ),
          );
          if (result == "saved") {
            onRefresh();
          }
          showSnackbar(context, result);
        }
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
                onRatingUpdate: (rating) async {
                  print("User gave $rating");
                  final result = await nextScreenMaterial(
                    context,
                    AddReviewPage(
                      rating: rating,
                      place: this.widget.place,
                    ),
                  );
                  if (result == "saved") {
                    onRefresh();
                  }
                  showSnackbar(context, result);
                  print(result);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    if (!_isLoading) {
      double pixels = _scrollController.position.pixels;
      if (pixels == _scrollController.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _getReviews();
      }
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      _isLoading = true;
      _snapshots.clear();
      _reviews.clear();
      _lastVisible = null;
    });
    Future.delayed(Duration(seconds: 2)).then((_) {
      _getCurrentUserReview();
      _getReviews();
    });
  }

  Future<void> _getReviews() async {
    final collection = "$_collectionPlaces/${widget.place.timestamp}/reviews";
    setState(() => _hasData = true);
    QuerySnapshot data;
    if (_lastVisible == null) {
      data = await firestore
          .collection(collection)
          // .where('uid', isNotEqualTo: _uid)
          .orderBy('timestamp', descending: true)
          .limit(7)
          .get();
    } else {
      data = await firestore
          .collection(collection)
          .orderBy('timestamp', descending: true)
          .startAfter([_lastVisible['timestamp']])
          .limit(7)
          .get();
    }

    if (data != null && data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        // await Future<void>.delayed(Duration(seconds: 1)).then((_) {
        //   print("Delayed");
        // });
        setState(() {
          _isLoading = false;
          _snapshots.addAll(data.docs);
          _reviews = _snapshots.map((r) {
            Review review = Review.fromFirestore(r);
            review.dateAdded =
                parseDate(review.timestamp, context.locale.toString());
            return review;
          }).toList();
          print('blog reviews : ${_reviews.length}');
        });
      }
    } else {
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
  }

  Future<void> _getCurrentUserReview() async {
    final collection = "$_collectionPlaces/${widget.place.timestamp}/reviews";
    QuerySnapshot data = await firestore
        .collection(collection)
        .where('uid', isEqualTo: _uid)
        .get();

    if (data.docs.length != 0) {
      setState(() {
        Review review = Review.fromFirestore(data.docs[0]);
        review.dateAdded =
            parseDate(review.timestamp, context.locale.toString());
        _userReview = review;
      });
    } else {
      setState(() {
        _userReview = null;
      });
    }
  }

  void _handleDelete(BuildContext context) {
    showYesNoDialog(
      context,
      () async {
        await context
            .read<ReviewBloc>()
            .deleteReview(widget.place.timestamp, _userReview.uid);
        Navigator.pop(context);
        showSnackbar(context, "Deleted");
        onRefresh();
      },
      title: "Delete?",
      message: "U sure u want to delete?",
    );
  }
}
