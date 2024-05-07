import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final double? height;
  final double? contentPadding;
  final double? width;
  final int? maxLine;
  final String? Function(String?)? validator; // Validator function
  const CustomInputField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.contentPadding = 20,
    required this.labelText,
    this.maxLine,
    this.width,
    this.height,
    this.prefixIcon,
    this.validator, // Validator parameter
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        // Using TextFormField for validation support
        readOnly: readOnly,
        maxLines: maxLine,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        validator: validator, // Passing the validator function
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: labelText,
          contentPadding: const EdgeInsets.only(left: 10, top: 10),
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3)),
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
