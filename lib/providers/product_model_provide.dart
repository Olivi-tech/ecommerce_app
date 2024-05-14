import 'package:e_commerece_admin_panel/models/ecommerce_product_model.dart';
import 'package:flutter/material.dart';

class ProductModelProvider extends ChangeNotifier {
  EcommerceProductModel? _ecommerceProductModel;
  EcommerceProductModel? get getEvents => _ecommerceProductModel;
  set setEvents(EcommerceProductModel? newProduct) {
    _ecommerceProductModel = newProduct;
    notifyListeners();
  }

  void clearEvents() {
    _ecommerceProductModel = null;
    notifyListeners();
  }

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;
  set setEditMode(bool value) {
    _isEditMode = value;
    notifyListeners();
  }

  void clearEditMode() {
    _isEditMode = false;
    notifyListeners();
  }
}
