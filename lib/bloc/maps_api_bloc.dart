import 'package:flutter/material.dart';
import 'package:xplore_bg/utils/api/failure.dart';
import 'package:xplore_bg/utils/api/maps_api.dart';

enum NotifierState { initial, loading, loaded, empty }

class MapsApiBloc extends ChangeNotifier {
  final _mapsAPI = MapsRESTApi();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  List<dynamic> _results;
  List<dynamic> get results => _results;
  void _setResults(List<dynamic> res) {
    _results = res;
    notifyListeners();
  }

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<void> getNearbyRest(double lat, double lng, String locale) async {
    _setState(NotifierState.loading);
    try {
      final res = await _mapsAPI.fetchRestData(lat, lng, locale);
      _setResults(res);
    } on Failure catch (f) {
      _setFailure(f);
    } on EmptyResult catch (_) {
      _setState(NotifierState.empty);
    }
    _setState(NotifierState.loaded);
  }
}
