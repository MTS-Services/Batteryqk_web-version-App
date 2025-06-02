
import 'package:flutter/material.dart';
import 'dilog_utils.dart';
final Map<String, TextEditingController> controllers = {
  'main': TextEditingController(),
  'sub': TextEditingController(),
  'sports': TextEditingController(),
};
void openAddCategoryDialog(BuildContext context) {
  showCustomFormDialog(
    context: context,
    title: 'Add New Category',
    confirmText: 'Add Category',
    cancelText: 'Cancel',
    fields: [
      _buildField('Main Category', controllers['main']!),
      _buildField('Sub Category', controllers['sub']!),
      _buildField('Sports', controllers['sports']!),
    ],
    onConfirm: () {
      controllers.forEach((key, controller) {
        print('$key: ${controller.text}');
      });
    },
  );
}
Widget _buildField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    ),
  );
}