import 'package:e_commerece_admin_panel/constants/app_colors.dart';
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
          style: const TextStyle(color: AppColors.red),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
