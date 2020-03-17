import 'package:flutter/material.dart';

class Home with ChangeNotifier {
  int _count = 0;
  bool _online = false;

  int get count => _count;
  bool get online => _online;

  set online(bool v) {
    _online = v;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}