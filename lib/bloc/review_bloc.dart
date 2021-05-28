import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore_bg/models/review.dart';
import 'package:xplore_bg/utils/misc.dart';

class ReviewBloc extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot _lastVisible;
  DocumentSnapshot get lastVisible => _lastVisible;

  bool _isLoading;
  bool get isLoading => _isLoading;

  bool _hasData = false;
  bool get hasData => _hasData;

  bool _addedReview = false;
  bool get addedReview => _addedReview;
  set newReview(bool added) => _addedReview = added;

  String _placeId;
  set placeId(String id) => _placeId = id;

  List<Review> _data;

  Future<void> getReviews() async {
    final String collection = 'locations/$_placeId/reviews';

    _hasData = true;
    notifyListeners();
    QuerySnapshot data;
    if (_lastVisible == null) {
      data = await firestore
          .collection(collection)
          .orderBy('timestamp', descending: true)
          .limit(8)
          .get();
    } else {
      data = await firestore
          .collection(collection)
          .orderBy('timestamp', descending: true)
          .startAfter([_lastVisible['timestamp']])
          .limit(8)
          .get();
    }

    if (data != null && data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      _isLoading = false;
      var snap = [];
      snap.addAll(data.docs);
      _data = snap.map((e) => Review.fromFirestore(e)).toList();
      print('reviews : ${_data.length}');
    } else {
      if (_lastVisible == null) {
        _isLoading = false;
        _hasData = false;
        print('no items');
      } else {
        _isLoading = false;
        _hasData = true;
        print('no more items');
      }
    }
    notifyListeners();
  }

  Future<void> saveNewReview(Review review, String placeId) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String _name = sp.getString('name');
    String _uid = sp.getString('uid');
    String _imageUrl = sp.getString('image_url');

    var _timestamp = getTimestamp();

    await firestore.collection('locations/$placeId/reviews').doc(_uid).set({
      'author': _name,
      'image_url': _imageUrl,
      'timestamp': _timestamp,
      'content': review.text,
      'rating': review.rating,
      'uid': _uid,
    }).then((_) async {
      final locRef = firestore.collection("locations").doc(placeId);
      // DocumentSnapshot snap = await locRef.get();

      firestore.runTransaction((transaction) async {
        var snapshot = await transaction.get(locRef);

        if (!snapshot.exists) {
          throw Exception("Does not exist!");
        }
        QuerySnapshot rev = await locRef.collection('reviews').get();

        int revCount = 0;
        double ratingTotal = 0;
        rev.docs.forEach((d) {
          var data = d.data();
          print(data);
          ratingTotal += data['rating'].toDouble() ?? 0.0;
          revCount++;
        });

        double rating = ratingTotal / revCount;
        int revs = snapshot['reviews_count'] as int ?? 0;
        transaction.update(locRef,
            {'reviews_count': ++revs, 'rating': rating.roundToDouble()});
        print('$_timestamp Review saved!');
        _addedReview = true;
      });
    });
    notifyListeners();
  }

  Future<void> deleteReview(String placeId, String reviewId) async {
    await firestore
        .collection("locations/$placeId/reviews")
        .doc(reviewId)
        .delete()
        .then((_) async {
      final locRef = firestore.collection("locations").doc(placeId);

      firestore.runTransaction((transaction) async {
        var snapshot = await transaction.get(locRef);

        if (!snapshot.exists) {
          throw Exception("Does not exist!");
        }
        QuerySnapshot rev = await locRef.collection('reviews').get();

        int revCount = 0;
        double ratingTotal = 0;
        rev.docs.forEach((d) {
          var data = d.data();
          print(data);
          ratingTotal += data['rating'].toDouble() ?? 0.0;
          revCount++;
        });

        double rating = ratingTotal / revCount;
        int revs = snapshot['reviews_count'] as int ?? 0;
        transaction.update(locRef,
            {'reviews_count': --revs, 'rating': rating.roundToDouble()});
      });
    });
  }
}
