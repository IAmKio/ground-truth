import 'package:flutter/material.dart';

class Report with ChangeNotifier {
  String _workingLayerId;
  double _workingLat;
  double _workingLong;

  double get workingLat => _workingLat;
  double get workingLong => _workingLong;
  String get workingLayerId => _workingLayerId;

  set workingLat(double v) {
    _workingLat = v;
    notifyListeners();
  }

  set workingLong(double v) {
    _workingLong = v;
    notifyListeners();
  }

  set workingLayerId(String v) {
    _workingLayerId = v;
    notifyListeners();
  }
}