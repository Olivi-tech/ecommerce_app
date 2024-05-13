import 'package:e_commerece_admin_panel/providers/drop_down_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';

class DJDropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final IconData icon;
  final String value;
  final TextEditingController controller;
  final void Function(String?) onChanged;
  final TextStyle? dropdownItemTextStyle;

  const DJDropDownWidget({
    super.key,
    required this.itemList,
    required this.icon,
    required this.controller,
    required this.onChanged,
    this.value = '',
    this.dropdownItemTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Consumer<DropDownProvider>(
        builder: (context, provider, child) {
          return DropdownButton(
            isExpanded: true,
            icon: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                icon,
                size: 15,
                color: AppColors.white,
              ),
            ),
            underline: const SizedBox(),
            alignment: Alignment.topRight,
            items: itemList.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: dropdownItemTextStyle,
                ),
              );
            }).toList(),
            onChanged: ((value) {
              provider.setSelectedOption(value!);
            }),
          );
        },
      ),
    );
  }
}
