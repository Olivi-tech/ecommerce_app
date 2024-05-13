import 'package:flutter/material.dart';

class RoutingProvider extends ChangeNotifier {
  int _index = 1;
  int get getindex => _index;
  void setindex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}
