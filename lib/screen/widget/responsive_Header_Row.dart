import 'package:batteryqk_web/screen/widget/table_header_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveHeaderRow extends StatelessWidget {
  final String id;
  final int? pointsFlex;
  final String name;
  final String email;
  final String joinDate;
  final String bookings;
  final String? points;
  final List<dynamic>? pointsIcons;
  final List<VoidCallback>? onPointsIconPressed;
  final List<Color>? pointsIconColors;
  final String actions;
  final List<dynamic>? actionIcons;
  final List<VoidCallback>? onActionIconPressed;
  final List<Color>? actionIconColors;
  final BorderRadius? radius;
  final double fontSize;
  final Color? textColor;
  final Color? hadingColor;
  final String? status;

  const ResponsiveHeaderRow({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.joinDate,
    required this.bookings,
    required this.points,
    this.pointsIcons,
    this.onPointsIconPressed,
    this.pointsIconColors,
    required this.actions,
    this.actionIcons,
    this.onActionIconPressed,
    this.actionIconColors,
    this.radius,
    required this.fontSize,
    this.textColor,
    this.hadingColor,
    this.status,
    this.pointsFlex,
  });

  @override
  Widget build(BuildContext context) {
    final textClr = textColor ?? Colors.black;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hadingColor,
            borderRadius: radius,
            border: Border.all(color: Colors.black12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildHeaderRow(fontSize, textClr),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildHeaderRow(double fontSize, Color textClr) {
    List<Widget> rowWidgets = [
      _responsiveBox(
        flex: 1,
        child: HeaderText(text: id, fontSize: fontSize, color: textClr),
      ),
      _responsiveBox(
        flex: 2,
        child: HeaderText(text: name, fontSize: fontSize, color: textClr),
      ),
      _responsiveBox(
        flex: 2,
        child: HeaderText(text: email, fontSize: fontSize, color: textClr),
      ),
      _responsiveBox(
        flex: 2,
        child: HeaderText(text: joinDate, fontSize: fontSize, color: textClr),
      ),
      _responsiveBox(
        flex: 2,
        child: HeaderText(text: bookings, fontSize: fontSize, color: textClr),
      ),
      _responsiveBox(
        flex: 1,
        child: HeaderText(text: status ?? '', fontSize: fontSize, color: textClr),
      ),
    ];

    if (points != null || (pointsIcons != null && pointsIcons!.isNotEmpty)) {
      rowWidgets.add(
        _responsiveBox(
          flex: pointsFlex ?? 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (points != null)
                HeaderText(text: points!, fontSize: fontSize, color: textClr),
              if (pointsIcons != null && pointsIcons!.isNotEmpty)
                ...List.generate(pointsIcons!.length, (index) {
                  final iconColor = (pointsIconColors != null && pointsIconColors!.length > index)
                      ? pointsIconColors![index]
                      : Colors.grey;

                  final icon = pointsIcons![index];
                  if (icon is IconData) {
                    return IconButton(
                      icon: Icon(icon, size: 18, color: iconColor),
                      onPressed: onPointsIconPressed != null && onPointsIconPressed!.length > index
                          ? onPointsIconPressed![index]
                          : null,
                      tooltip: 'Point Icon ${index + 1}',
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      constraints: const BoxConstraints(),
                    );
                  } else if (icon is String) {
                    // Handle string-to-icon conversion (if using strings as icons)
                    IconData? convertedIcon = _getIconFromString(icon);
                    return convertedIcon != null
                        ? IconButton(
                      icon: Icon(convertedIcon, size: 18, color: iconColor),
                      onPressed: onPointsIconPressed != null && onPointsIconPressed!.length > index
                          ? onPointsIconPressed![index]
                          : null,
                      tooltip: 'Point Icon ${index + 1}',
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      constraints: const BoxConstraints(),
                    )
                        : Text(icon, style: TextStyle(fontSize: fontSize, color: iconColor));
                  } else {
                    return Container();
                  }
                }),
            ],
          ),
        ),
      );
    }

    rowWidgets.add(
      _responsiveBox(
        flex: 1,
        child: Row(
          children: [
            HeaderText(text: actions, fontSize: fontSize, color: textClr),
            if (actionIcons != null && actionIcons!.isNotEmpty)
              ...List.generate(actionIcons!.length, (index) {
                final iconColor = (actionIconColors != null && actionIconColors!.length > index)
                    ? actionIconColors![index]
                    : Colors.grey;

                final icon = actionIcons![index];
                if (icon is IconData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: IconButton(
                      icon: Icon(icon, size: 18, color: iconColor),
                      onPressed: onActionIconPressed != null && onActionIconPressed!.length > index
                          ? onActionIconPressed![index]
                          : null,
                      tooltip: 'Action ${index + 1}',
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                    ),
                  );
                } else if (icon is String) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(icon, style: TextStyle(fontSize: fontSize, color: iconColor)),
                  );
                } else {
                  return Container();
                }
              }),
          ],
        ),
      ),
    );

    return rowWidgets;
  }

  Widget _responsiveBox({required int flex, required Widget child}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: child,
      ),
    );
  }

  // Helper function to convert string to IconData
  IconData? _getIconFromString(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'settings':
        return Icons.settings;
      case 'favorite':
        return Icons.favorite;
    // Add more mappings here
      default:
        return null;
    }
  }
}
