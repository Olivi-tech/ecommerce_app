import 'package:flutter/material.dart';

class CustomSnackBar {
  static showSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: isError ? Colors.red : Colors.white),
        ),
        backgroundColor: isError ? Colors.black : Colors.green,
      ),
    );
  }
}
