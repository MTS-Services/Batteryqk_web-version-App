import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final double? iconSize;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const HeaderText({
    super.key,
    this.text,
    this.icon,
    this.iconSize,
    this.color = Colors.grey,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  double _getFontSize(double width) {
    if (width < 600) {
      return 12;
    } else if (width < 1024) {
      return 14;
    } else {
      return 16;
    }
  }

  double _getIconSize(double width) {
    if (iconSize != null) return iconSize!;
    if (width < 600) {
      return 12;
    } else if (width < 1024) {
      return 18;
    } else {
      return 20;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = _getFontSize(width);
    final iconActualSize = _getIconSize(width);

    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            size: iconActualSize,
            color: color,
          ),
        if (icon != null && text != null)
          const SizedBox(width: 6),
        if (text != null)
          Text(
            text!,
            style: TextStyle(
              fontWeight: fontWeight,
              color: color,
              fontSize: fontSize,
              letterSpacing: 0.5,
            ),
          ),
      ],
    );
  }
}
