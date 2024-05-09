import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final double? height;
  final double? contentPadding;
  final bool isVisibleText;
  final double? width;
  final int? maxLine;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters; // Validator function
  const CustomInputField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.contentPadding = 20,
    this.isVisibleText = false,
    required this.labelText,
    this.maxLine,
    this.inputFormatters,
    this.width,
    this.height,
    this.prefixIcon,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        readOnly: readOnly,
        maxLines: maxLine,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isVisibleText,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: labelText,
          contentPadding: const EdgeInsets.only(left: 10, top: 10),
          hintStyle: TextStyle(color: AppColors.black.withOpacity(0.3)),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.darkGrey),
          ),
        ),
      ),
    );
  }
}
