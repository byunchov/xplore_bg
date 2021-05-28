import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:xplore_bg/models/place.dart';

class FeaturedBloc with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Place> _data = [];
  List<Place> get data => _data;

  String _locale = 'bg';
  set locale(String loc) {
    this._locale = _locale;
  }

  List featuredList = [];

  // this is the ONE XD
  Future<List<Place>> _getPlaceData() async {
    List<Place> places = [];
    final _ref = firestore.collection('featured').doc('featured_list');
    var snap = await _ref.get();
    var fl = List<DocumentReference>.from(snap['featured_locations']);

    for (var item in fl) {
      var locRef = item.collection('locales').doc(_locale);
      var trData = await locRef.get();
      var pdata = await item.get();
      Place p = Place.fromFirestore(pdata, _locale);
      p.placeTranslation = PlaceTranslation.fromFirebase(trData);
      places.add(p);
    }

    return places;
  }

  Future<void> fetchData() async {
    _data = await _getPlaceData();
    notifyListeners();
  }

  void onRefresh() {
    _data.clear();
    fetchData();
    notifyListeners();
  }

  void onClick() {
    fetchData();
  }
}
