import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetBloc extends ChangeNotifier {
  bool _hasInternet = false;

  InternetBloc() {
    checkConnectivity();
  }

  bool get hasInternet => _hasInternet;

  checkConnectivity() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      _hasInternet = false;
    } else {
      _hasInternet = true;
    }
    notifyListeners();
  }
}
