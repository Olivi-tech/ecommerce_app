import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isColor;
  final Color? color;
  final Color textColor;
  final String text;
  final double? width;
  final bool isLoading;

  const CustomButton({
    Key? key,
    this.isColor = false,
    this.color,
    this.isLoading = false,
    this.textColor = Colors.black,
    required this.onPressed,
    required this.text,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: TextStyle(color: textColor),
              ),
      ),
    );
  }
}
