import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DropDownContainer extends StatelessWidget {
  const DropDownContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      body: Container(
        height: height * 0.5,
        width: width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.red,
        ),
      ),
    );
  }
}
