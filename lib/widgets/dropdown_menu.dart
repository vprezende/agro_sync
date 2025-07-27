import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownMenu<T> extends StatelessWidget {

  final T? value;
  final Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final String hintText;

  const DropdownMenu({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        iconColor: Colors.grey,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      menuItemStyleData:MenuItemStyleData(
        overlayColor: WidgetStateProperty.all(Colors.grey.shade300),
      ),
      value: value,
      hint: Center(
        child: Text(
          hintText,
          style: TextStyle(
            color: Colors.grey.shade500
          ),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}