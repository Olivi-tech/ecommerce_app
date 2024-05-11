import 'package:e_commerece_admin_panel/utils/call_back_function.dart';
import 'package:e_commerece_admin_panel/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final double? height;
  final OnChanged onChanged;
  final ValidatorFormField? validator;
  final TextInputType? keyBoardType;
  final Color? fillColor;
  final bool isFilled;
  final FontWeight? weight;
  final TextStyle? hintStyle;

  final int? maxLines;
  final bool readOnly;
  final bool isCommentField;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;
  final String? trailingText;
  final bool isTrailingText;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.suffixIcon,
    this.weight,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
    this.height = 56,
    this.inputFormatters,
    this.isVisibleText = false,
    this.readOnly = false,
    this.obscuringCharacter = '*',
    this.prefixIcon,
    this.fillColor,
    this.isFilled = false,
    this.trailingText,
    this.isTrailingText = false,
    this.isCommentField = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscuringCharacter: obscuringCharacter,
      cursorColor: AppColors.black.withOpacity(0.3),
      obscureText: isVisibleText,
      cursorHeight: 27,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, left: 17),
        hintText: hintText,
        alignLabelWithHint: true,
        suffixIcon: isTrailingText
            ? Padding(
                padding: const EdgeInsets.only(top: 15, right: 20),
                child: CustomText(
                  label: '$trailingText',
                  weight: FontWeight.w600,
                  size: 14,
                ),
              )
            : suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: isFilled,
        enabledBorder: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.darkGrey,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.darkGrey,
            )),
        border: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.darkGrey,
            )),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        suffixStyle: suffixStyle,
      ),
      keyboardType: keyBoardType,
    );
  }
}
