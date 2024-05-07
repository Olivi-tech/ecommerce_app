import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final bool isBorder;
  final Color? borderColor;
  final Widget? child;

  const CustomContainer(
      {super.key,
      this.height,
      this.width,
      this.borderColor = AppColors.darkGrey,
      this.child,
      this.color,
      this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor!),
          color: color,
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
