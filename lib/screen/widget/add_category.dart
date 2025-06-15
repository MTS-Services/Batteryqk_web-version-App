import 'package:batteryqk_web/data/model/catagory_create_model.dart';
import 'package:batteryqk_web/screen/widget/show_Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../data/model/sum_category_model.dart';
import 'custom_dropdown_button.dart';
import 'dilog_utils.dart';

final Map<String, TextEditingController> controllers = {
  'main': TextEditingController(),
  'sub': TextEditingController(),
  'sports': TextEditingController(),
};

void openAddCategoryDialog(BuildContext context) {
  String selectedStatus = 'All Statuses';
  final createCategory = Get.put(CategoryController());

  showCustomFormDialog(
    context: context,
    title: 'Add New Category',
    confirmText: 'Add Category',
    cancelText: 'Cancel',
    fields: [
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusDropdown(
                dropdownBgColor: Colors.white,
                focusedBorderColor: Colors.white,
                value: selectedStatus,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedStatus = val);
                  }
                },
                statusList: [
                  'All Statuses',
                  'Confirmed',
                  'Pending',
                  'Canceled',
                ],
                hintText: 'Choose status',
                labelText: 'Filter by Status',
                borderRadius: 10,
                fontSize: 15,
              ),
              const SizedBox(height: 10),
              _buildField(
                'Main Category',
                controllers['main']!,
                enabled: selectedStatus == 'All Statuses',
              ),
              _buildField('Sub Category', controllers['sub']!),
              _buildField('Sports (comma-separated)', controllers['sports']!),
            ],
          );
        },
      ),
    ],
    onConfirm: () async {
      final main = controllers['main']!.text.trim();
      final sub = controllers['sub']!.text.trim();
      final sportsRaw = controllers['sports']!.text.trim();

      // Validate all fields
      if (main.isEmpty || sub.isEmpty || sportsRaw.isEmpty) {
        showSnackbar('Error', 'All fields are required');
        return;
      }

      final List<String> sportsList = sportsRaw
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final SubCategory subCategory = SubCategory(
        name: sub,
        specificItems: sportsList,
      );


      final CategoryCreateModel newCategory = CategoryCreateModel(
        mainCategory: main,
        subCategories: [subCategory],
      );

      final bool success = await createCategory.createCategory(newCategory);
      if (success) {
        controllers.forEach((_, c) => c.clear());
      }
    },
  );
}

Widget _buildField(
    String label,
    TextEditingController controller, {
      bool enabled = true,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        helperText: label == 'Sports (comma-separated)'
            ? 'Use comma to separate multiple sports'
            : null,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}
