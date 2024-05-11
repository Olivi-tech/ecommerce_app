import 'package:e_commerece_admin_panel/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DJDropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final IconData icon;
  final String value;

  final void Function(String?) onChanged;

  const DJDropDownWidget({
    super.key,
    required this.itemList,
    required this.icon,
    required this.onChanged,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownButton(
        isExpanded: true,
        icon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(
            icon,
            color: AppColors.greyColor,
          ),
        ),
        underline: const SizedBox(),
        alignment: Alignment.topRight,
        items: itemList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
