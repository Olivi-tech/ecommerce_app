import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String label;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  const CustomText({
    super.key,
    required this.label,
    this.weight,
    this.color,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
