import 'package:flutter/material.dart';

class ScreenTransitionProvider extends ChangeNotifier {
  int _screenIndex = 0;
  get getIndex => _screenIndex;
  set setIndex(int index) {
    _screenIndex = index;
    notifyListeners();
  }
}
