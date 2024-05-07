import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> options;
  final ValueNotifier<String> selectedValue;
  final TextEditingController controller;
  const CustomDropDown({
    super.key,
    required this.controller,
    required this.options,
    required this.selectedValue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ValueListenableBuilder<String>(
        valueListenable: selectedValue,
        builder: (context, value, child) {
          return DropdownButton<String>(
            style: const TextStyle(
              color: Colors.black,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            elevation: 16,
            isExpanded: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            underline: Container(
              height: 0,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            value: value,
            onChanged: (newValue) {
              selectedValue.value = newValue!;
              controller.text = newValue;
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
