import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore_bg/models/place.dart';

class SearchBloc with ChangeNotifier {
  SearchBloc() {
    getRecentSearchList();
  }

  List<String> _recentSearchHistory = [];
  List<String> get recentSearchHistory => _recentSearchHistory;

  String _searchText = '';
  String get searchText => _searchText;

  bool _searchStarted = false;
  bool get searchStarted => _searchStarted;

  TextEditingController _textFieldCtrl = TextEditingController();
  TextEditingController get textfieldCtrl => _textFieldCtrl;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getRecentSearchList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchHistory = sp.getStringList('recent_search_history') ?? [];
    notifyListeners();
  }

  Future addToSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchHistory.add(value);
    await sp.setStringList('recent_search_history', _recentSearchHistory);
    notifyListeners();
  }

  Future removeFromSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchHistory.remove(value);
    await sp.setStringList('recent_search_history', _recentSearchHistory);
    notifyListeners();
  }

  Future<List> fetchData(String locale) async {
    List<Place> data = [];
    List<Place> places = [];
    QuerySnapshot rawData = await firestore
        .collection('locations')
        .orderBy('timestamp', descending: true)
        .get();

    List<DocumentSnapshot> _snap = [];

    _snap.addAll(rawData.docs);
    for (var item in _snap) {
      var locRef = item.reference.collection('locales').doc(locale);
      var trData = await locRef.get();
      Place p = Place.fromFirestore(item, locale);
      p.placeTranslation = PlaceTranslation.fromFirebase(trData);
      places.add(p);
    }
    data = places.where((item) {
      var search = _searchText.toLowerCase().trim();
      return (item.placeTranslation.name.toLowerCase().contains(search) ||
          item.placeTranslation.residence.toLowerCase().contains(search));
    }).toList();
    return data;
  }

  setSearchText(value) {
    _textFieldCtrl.text = value;
    _searchText = value;
    _searchStarted = true;
    notifyListeners();
  }

  saerchInitialize() {
    _textFieldCtrl.clear();
    _searchStarted = false;
    notifyListeners();
  }
}
