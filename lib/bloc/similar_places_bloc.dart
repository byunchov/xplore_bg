import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg/models/place.dart';

class SimilarPlacesBloc extends ChangeNotifier {
  List<Place> _data = [];
  List<Place> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchData(String id, String category, String locale) async {
    _data.clear();
    List<DocumentSnapshot> _snap = [];
    List<Place> places = [];

    // print("Simiral: $category, $id");

    final rawData = await firestore
        .collection('locations')
        .where('category', isEqualTo: category)
        .orderBy('loves_count', descending: true)
        .limit(6)
        .get();

    _snap.addAll(rawData.docs);
    int indexOf = _snap.indexWhere((item) => item['timestamp'] == id);
    if (indexOf >= 0) {
      _snap.removeAt(indexOf);
    }

    print("Found element with ID $id at postition $indexOf");
    for (var item in _snap) {
      var locRef = item.reference.collection('locales').doc(locale);
      var trData = await locRef.get();
      Place p = Place.fromFirestore(item, locale);
      p.placeTranslation = PlaceTranslation.fromFirebase(trData);
      places.add(p);
      print("Cat tag: ${p.categoryTag}");
    }
    if (places.isNotEmpty) {
      _data.addAll(places);
    } else {
      _data = null;
    }
    print(places);
    notifyListeners();
  }

  void onRefresh() {}
}
