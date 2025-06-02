import 'package:flutter/material.dart';

import 'CustomeDilogBox.dart';

void showCustomFormDialog({
  required BuildContext context,
  required String title,
  required List<Widget> fields,
  String confirmText = 'Submit',
  String cancelText = 'Cancel',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Color bgColor = Colors.white,
}) {
  showDialog(
    context: context,
    builder: (context) => CustomFlexibleDialog(
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields,
      ),
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      backgroundColor: bgColor, 
    ),
  );
}
