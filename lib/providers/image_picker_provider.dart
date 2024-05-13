import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier {
  Uint8List _imageBytes = Uint8List.fromList([]);
  String _imageUrl = '';

  Uint8List get getImageBytes {
    return _imageBytes;
  }

  set setImageBytes(Uint8List? bytes) {
    _imageBytes = bytes!;
    notifyListeners();
  }

  String get getImageUrl {
    return _imageUrl;
  }

  set setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }

  void clear() {
    _imageUrl = '';
    _imageBytes = Uint8List.fromList([]);
    notifyListeners();
  }
}
