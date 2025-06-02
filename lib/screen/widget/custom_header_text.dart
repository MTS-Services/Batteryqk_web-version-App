import 'package:flutter/material.dart';

class CustomHeadingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const CustomHeadingText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
      ),
    );
  }
}
