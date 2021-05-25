import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/internet_bloc.dart';
import 'package:xplore_bg/bloc/review_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/models/place.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/misc.dart';

class AddReviewPage extends StatefulWidget {
  final double rating;
  final Place place;
  final Review review;

  const AddReviewPage({
    Key key,
    this.rating,
    this.place,
    this.review,
  }) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _uid;

  @override
  void initState() {
    _uid = context.read<SigninBloc>().uid;
    _textController.text = widget.review.text ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _sb = context.read<SigninBloc>();
    var _screenWidth = MediaQuery.of(context).size.width;
    double _rating = (widget.rating ?? widget.review.rating) ?? 0;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.place.placeTranslation.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context, "dismissed");
            },
          ),
        ),
        body: Builder(builder: (ctx) {
          return Container(
            width: _screenWidth,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CustomCachedImage(
                            imageUrl: _sb.imageUrl,
                          ),
                        ),
                      ),
                      SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _sb.name,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Public post",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: false,
                    glowColor: Colors.amber[300],
                    itemPadding: EdgeInsets.symmetric(horizontal: 12),
                    itemSize: 36,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating;
                      print("User gave $_rating");
                    },
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Share your experience',
                      hintText: 'Share more about your experience',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        showSnackbar(context, "Please, enter some text!");
                        return 'Please, enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: _screenWidth,
                      height: 45,
                    ),
                    child: ElevatedButton(
                      child: Text("Submit".toUpperCase()),
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Review review = Review(
                            rating: _rating,
                            text: _textController.text.trim(),
                            uid: _sb.uid,
                          );
                          _handleReviewPost(ctx, review);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future _handleReviewPost(BuildContext context, Review review) async {
    final ib = Provider.of<InternetBloc>(context, listen: false);
    await ib.checkConnectivity();
    if (ib.hasInternet == false) {
      print("No internet");
    } else {
      context.read<ReviewBloc>().saveNewReview(review, widget.place.timestamp);
      // FocusScope.of(context).requestFocus(new FocusNode());
      // Navigator.of(context).pop();
      // showSnackbar(context, "Added review!");
      Navigator.pop(context, "saved");
    }
  }
}
