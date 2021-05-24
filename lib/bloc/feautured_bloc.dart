import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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

  Future getTest() async {
    final ref = firestore.collection('featured').doc('featured_list');
    var snap = await ref.get();
    // var loc = await (snap['featured_locations'][0] as DocumentReference).get();
    var s = snap['featured_locations'][0] as DocumentReference;
    var fl = snap['featured_locations']; //as List<DocumentReference>;

    List<Place> pl = [];
    fl.forEach((f) async {
      await f.snapshots().listen((d) {
        var data = d.data();
        Place p = _fillPlaceDetails(data);
        pl.add(p);
        print(p.category);
      });
    });
    _data.addAll(pl);
    print(data);
    notifyListeners();
    // s.snapshots().listen((data) => print(data.data()));
  }

  Future<List> _getFeaturedList() async {
    final DocumentReference ref =
        firestore.collection('featured').doc('featured_list');
    DocumentSnapshot snap = await ref.get();
    // featuredList = snap['featured_locations'] ?? [];
    List<dynamic> ids = [];
    snap['featured_locations'].forEach((f) {
      String path = f.path as String;
      ids.add(path.substring(path.lastIndexOf('/') + 1));
    });
    return ids;
    // return featuredList;
  }

  Future<List<Place>> _getPlaceData() async {
    List<Place> places = [];
    final _ref = firestore.collection('featured').doc('featured_list');
    var snap = await _ref.get();
    var fl = List<DocumentReference>.from(snap['featured_locations']);

    // fl.forEach((f) async {
    //   var locRef = f.collection('locales').doc(_locale);
    //   var trData = await locRef.get();
    //   var pdata = await f.get();
    //   Place p = Place.fromFirestore(pdata, _locale);
    //   p.placeTranslation = PlaceTranslation.fromFirebase(trData);
    //   places.add(p);
    // });

    for (var item in fl) {
      var locRef = item.collection('locales').doc(_locale);
      var trData = await locRef.get();
      var pdata = await item.get();
      Place p = Place.fromFirestore(pdata, _locale);
      p.placeTranslation = PlaceTranslation.fromFirebase(trData);
      places.add(p);
    }
    print(places);

    return places;
  }

  Future<void> fetchData() async {
    _data = await _getPlaceData();
    notifyListeners();
  }

  Future<List<Place>> _fillData(var list) async {
    List<Place> pl = [];
    list.forEach((f) async {
      await f.snapshots().listen((d) {
        var data = d.data();
        Place p = _fillPlaceDetails(data);
        pl.add(p);
        print(p.category);
      });
    });
    return pl;
  }

  Future getFData() async {
    _getFeaturedList().then((featuredList) async {
      _fillData(featuredList).then((l) {
        _data.addAll(l);
        print(_data);
        notifyListeners();
      });
    });
  }

  Future getData() async {
    await _getFeaturedList().then((featuredList) async {
      QuerySnapshot rawData;
      rawData = await firestore
          .collection('locations')
          .where('timestamp', whereIn: featuredList)
          .limit(5)
          .get();

      List<DocumentSnapshot> _snaps = [];
      _snaps.addAll(rawData.docs);
      // _data = _snap.map((e) => Place.fromFirestore(e)).toList();
      _data = _snaps.map((snap) => _fillPlaceDetails(snap)).toList();
      notifyListeners();
    });
  }

  Place _fillPlaceDetails(DocumentSnapshot snap) {
    Place place = Place();
    var data = snap.data();

    place.region = data['region_tr'][_locale];
    place.latitude = data['coordinates']['lat'] ?? 0;
    place.longitude = data['coordinates']['lng'] ?? 0;
    place.gallery = data['gallery'];
    place.reviewsCount = data['reviews_count'];
    place.timestamp = data['timestamp'];
    place.category = data['category_tr'][_locale];
    place.subcategory = data['subcategory_tr'][_locale];
    place.starRating = data['rating'] ?? 0.0;
    place.loves = data['loves_count'] ?? 0;
    place.bookmarksCount = data['bookmarks_count'] ?? 0;

    print('${place.latitude}|${place.longitude}');

    return place;
  }

  onRefresh() {
    featuredList.clear();
    _data.clear();
    getData();
    notifyListeners();
  }

  void onClick() {
    fetchData();
  }
}
