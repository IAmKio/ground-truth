import 'package:flutter/material.dart';

class Home with ChangeNotifier {
  int _count = 0;
  bool _online = false;
  String _workingLayerId;
  double _workingLat;
  double _workingLong;

  int get count => _count;
  bool get online => _online;
  double get workingLat => _workingLat;
  double get workingLong => _workingLong;
  String get workingLayerId => _workingLayerId;

  set online(bool v) {
    _online = v;
    notifyListeners();
  }

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

  void increment() {
    _count++;
    notifyListeners();
  }
}