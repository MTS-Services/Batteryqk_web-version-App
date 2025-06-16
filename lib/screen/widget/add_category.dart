import 'package:batteryqk_web/data/model/catagory_create_model.dart';
import 'package:batteryqk_web/screen/widget/show_Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';
import '../../controller/item_controller.dart';
import '../../data/model/sub_category_model.dart';
import 'custom_dropdown_button.dart';
import 'dilog_utils.dart';

final Map<String, TextEditingController> controllers = {
  'main': TextEditingController(),
  'sub': TextEditingController(),
  'sports': TextEditingController(),
  'dropdown': TextEditingController(text: 'All Statuses'),
};

void openAddCategoryDialog(BuildContext context) async {
  final createCategory = Get.put(CategoryController());
  final ItemController controller = Get.put(ItemController());

  await controller.fetchItems();

  List<String> subOptions = [];
  List<String> sportOptions = [];

  showCustomFormDialog(
    context: context,
    title: 'Add New Category',
    confirmText: 'Add Category',
    cancelText: 'Cancel',
    fields: [
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          final selectedMain = controllers['dropdown']!.text;

          subOptions = selectedMain != 'All Statuses'
              ? controller.itemList
              .where((item) => item.mainCategory.name == selectedMain)
              .expand((item) => item.subCategories.map((e) => e.name))
              .toList()
              : [];

          sportOptions = selectedMain != 'All Statuses'
              ? controller.itemList
              .where((item) => item.mainCategory.name == selectedMain)
              .expand((item) => item.subCategories)
              .expand((sub) => sub.specificItems.map((e) => e.name))
              .toList()
              : [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusDropdown(
                dropdownBgColor: Colors.white,
                focusedBorderColor: Colors.white,
                value: selectedMain,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      controllers['dropdown']!.text = val;
                      controllers['main']!.clear();
                    });
                  }
                },
                statusList: [
                  'All Statuses',
                  ...controller.itemList.map((item) => item.mainCategory.name)
                ],
                labelText: 'Select Main Category',
                borderRadius: 10,
                fontSize: 15,
              ),
              const SizedBox(height: 10),
              if (selectedMain == 'All Statuses')
                _buildField('Main Category', controllers['main']!),
              _buildField('Sub Category', controllers['sub']!),
              _buildField('Sports (comma-separated)', controllers['sports']!),
              if (subOptions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Existing Sub Categories: ${subOptions.join(", ")}"),
                ),
              if (sportOptions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Existing Sports: ${sportOptions.join(", ")}"),
                ),
            ],
          );
        },
      ),
    ],
    onConfirm: () async {
      final main = controllers['dropdown']!.text == 'All Statuses'
          ? controllers['main']!.text.trim()
          : controllers['dropdown']!.text;

      final sub = controllers['sub']!.text.trim();
      final sportsRaw = controllers['sports']!.text.trim();

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
        controllers['dropdown']!.text = 'All Statuses';
      }
    },
  );
}

Widget _buildField(String label, TextEditingController controller, {bool enabled = true}) {
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
