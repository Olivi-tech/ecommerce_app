import 'package:flutter/material.dart';

class CustomSize extends StatelessWidget {
  final double? height;
  final double? width;
  const CustomSize({super.key, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
