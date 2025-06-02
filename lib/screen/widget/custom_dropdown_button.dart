import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class StatusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final List<String> statusList;
  final String labelText;
  final String? hintText;
  final double borderRadius;
  final double fontSize;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color iconColor;
  final Color dropdownBgColor;
  final Color textColor;

  const StatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.statusList,
    this.labelText = 'Status',
    this.hintText,
    this.borderRadius = 6,
    this.fontSize = 14,
    this.borderColor = Colors.black12,
    this.focusedBorderColor = Colors.blue,
    this.iconColor = Colors.black,
    this.dropdownBgColor = Colors.white,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: value,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      hint: Icon(Icons.arrow_drop_down, color: iconColor),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: dropdownBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      items: statusList.map((String status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(
            status,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
