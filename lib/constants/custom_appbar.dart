import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:e_commerece_admin_panel/utils/call_back_function.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class CustomAppBar extends StatefulWidget {
  final TextEditingController? controller;
  final SearchCallbackFunc? setSearchValue;
  final String? text;
  const CustomAppBar(
      {Key? key, this.controller, this.setSearchValue, this.text})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * 0.06,
              width: width * 0.3,
              child: ValueListenableBuilder(
                valueListenable: widget.controller!,
                builder: (context, value, child) => CustomTextField(
                  controller: widget.controller,
                  onChanged: (query) {
                    print("Search query: $query");
                    widget.setSearchValue!(query);
                  },
                  fillColor: AppColors.white,
                  isFilled: true,
                  hintText: widget.text,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.darkGrey,
                  ),
                  suffixIcon: widget.controller!.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            widget.controller!.clear();
                            widget.setSearchValue!(widget.controller!.text);
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColors.darkGrey,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
