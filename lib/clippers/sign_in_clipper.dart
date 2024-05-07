import 'package:flutter/material.dart';

class SignInClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    Path path = Path();
    path.lineTo(width * 0.5, 0);
    path.cubicTo(
        width * 0.62, height * 0.12, width, height * 0.4, width * 0.8, height);
    path.lineTo(0, height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
