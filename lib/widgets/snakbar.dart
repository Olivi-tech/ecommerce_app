import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.black,
        content: Text(
          message,
          style: const TextStyle(color: AppColors.red),
        ),
      ),
    );
  }
}
