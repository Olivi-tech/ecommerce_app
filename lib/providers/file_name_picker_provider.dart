import 'package:flutter/cupertino.dart';

class FileNamePickerProvider extends ChangeNotifier {
  String _fileName = '';

  String get getFileName => _fileName;

  set setFileName(String value) {
    _fileName = value;
    notifyListeners();
  }

  void clearFileName() {
    _fileName = '';
    notifyListeners();
  }
}
