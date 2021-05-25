import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore_bg/models/place.dart';

class BookmarkBloc extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List> getBookmarksData(String field, String locale) async {
    String _collection = 'locations';
    // String _field = 'bookmarked_places';
    List<Place> places = [];
    List<DocumentSnapshot> _snap = [];

    SharedPreferences sp = await SharedPreferences.getInstance();
    String _uid = sp.getString('uid');

    final ref = firestore.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    var ids = snap[field];

    if (ids.isNotEmpty) {
      QuerySnapshot rawData = await firestore
          .collection(_collection)
          .where('timestamp', whereIn: ids)
          .get();

      _snap.addAll(rawData.docs);
      for (var item in _snap) {
        var locRef = item.reference.collection('locales').doc(locale);
        var trData = await locRef.get();
        Place p = Place.fromFirestore(item, locale);
        p.placeTranslation = PlaceTranslation.fromFirebase(trData);
        places.add(p);
      }
    }

    return places;
  }

  Future<void> onBookmarkIconClick(String timestamp) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String _uid = sp.getString('uid');
    String _collection = 'locations';
    String _bmListField = 'bookmarked_places';
    String _bmCountField = 'bookmarks_count';
    String _colField = 'bookmarks_count';

    final locRef = firestore.collection(_collection).doc(timestamp);
    final ref = firestore.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    int bookmarkCount = snap[_bmCountField] as int ?? 0;
    List bookmarked = snap[_bmListField];

    firestore.runTransaction((transaction) async {
      var snapshot = await transaction.get(locRef);

      if (!snapshot.exists) {
        throw Exception("Does not exist!");
      }

      var data = snapshot.data();
      int bc = data[_colField] as int;

      if (bookmarked.contains(timestamp)) {
        List<String> rem = [];
        rem.add(timestamp);
        bookmarkCount--;
        bookmarkCount = (bookmarkCount > 0) ? bookmarkCount : 0;
        transaction.update(locRef, {_colField: --bc});
        await ref.update({
          _bmListField: FieldValue.arrayRemove(rem),
          _bmCountField: bookmarkCount,
        });
        sp.setInt('bookmarks_count', bookmarkCount);
      } else {
        bookmarked.add(timestamp);
        transaction.update(locRef, {_colField: ++bc});
        await ref.update({
          _bmListField: FieldValue.arrayUnion(bookmarked),
          _bmCountField: ++bookmarkCount,
        });
        sp.setInt('bookmarks_count', bookmarkCount);
      }
    });
    notifyListeners();
  }

  Future<void> onLoveIconClick(String timestamp) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String _uid = sp.getString('uid');
    String _collection = 'locations';
    String _lvListField = 'loved_places';
    String _lvCountField = 'loved_count';
    String _colField = 'loves_count';

    final locRef = firestore.collection(_collection).doc(timestamp);
    final ref = firestore.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    int lovedCount = snap[_lvCountField] as int ?? 0;
    List loved = snap[_lvListField];

    firestore.runTransaction((transaction) async {
      var snapshot = await transaction.get(locRef);

      if (!snapshot.exists) {
        throw Exception("Does not exist!");
      }

      var data = snapshot.data();
      int lc = data[_colField] as int;

      if (loved.contains(timestamp)) {
        List<String> rem = [];
        rem.add(timestamp);
        lovedCount--;
        lovedCount = (lovedCount > 0) ? lovedCount : 0;
        await ref.update({
          _lvListField: FieldValue.arrayRemove(rem),
          _lvCountField: lovedCount,
        });
        transaction.update(locRef, {_colField: --lc});
      } else {
        loved.add(timestamp);
        await ref.update({
          _lvListField: FieldValue.arrayUnion(loved),
          _lvCountField: ++lovedCount,
        });
        transaction.update(locRef, {_colField: ++lc});
      }
    });

    notifyListeners();
  }
}
