import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DropDownProvider extends ChangeNotifier {
  List<String> _dropdownOptions = [];
  List<String> get dropdownOptions => _dropdownOptions;

  String _selectedOption = '';
  String get selectedOption => _selectedOption;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DropDownProvider() {
    Firebase.initializeApp().then((_) {
      _getDropdownOptionsFromFirebase();
    });
  }

  Future<void> _getDropdownOptionsFromFirebase() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();

      _dropdownOptions = querySnapshot.docs
          .map((doc) =>
              (doc.data() as Map<String, dynamic>)['category'] as String)
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error getting dropdown options: $e');
    }
  }

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void clearSelectedCategory() {
    _selectedOption = '';
    notifyListeners();
  }
}
