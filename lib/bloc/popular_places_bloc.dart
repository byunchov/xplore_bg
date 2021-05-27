import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg/models/place.dart';

class PopularPlacesBloc extends ChangeNotifier {
  List<Place> _data = [];
  List<Place> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchData(String locale) async {
    List<DocumentSnapshot> _snap = [];
    List<Place> places = [];

    final rawData = await firestore
        .collection('locations')
        .orderBy('loves_count', descending: true)
        .limit(10)
        .get();

    _snap.addAll(rawData.docs);
    for (var item in _snap) {
      var locRef = item.reference.collection('locales').doc(locale);
      var trData = await locRef.get();
      Place p = Place.fromFirestore(item, locale);
      p.placeTranslation = PlaceTranslation.fromFirebase(trData);
      places.add(p);
    }
    _data.addAll(places);
    notifyListeners();
  }

  void onRefresh(String locale) {
    _data.clear();
    fetchData(locale);
    notifyListeners();
  }
}
