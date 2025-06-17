import 'dart:io' show File;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import '../../controller/item_controller.dart';
import '../../controller/listing_controller.dart';
import 'file_picker_helper.dart';
import 'custom_dropdown_button.dart';
import 'dilog_utils.dart';
chooseFileBox(
    BuildContext context, {
      required TextEditingController nameController,
      required TextEditingController locationController,
      required TextEditingController ageGroupController,
      required TextEditingController priceController,
      required TextEditingController descriptionController,
      required TextEditingController facilityController,
      required TextEditingController mainController,
      required TextEditingController subController1,
      required TextEditingController subController2,
      required TextEditingController subController3,
      required TextEditingController subController4,
    }) {
  final _formKey = GlobalKey<FormState>();
  final ListingController listingController = Get.find<ListingController>();
  final ItemController controller = Get.put(ItemController());

  final Rx<dynamic> mainImageFile = Rx<dynamic>(null);
  final Rx<dynamic> subImageFile1 = Rx<dynamic>(null);
  final Rx<dynamic> subImageFile2 = Rx<dynamic>(null);
  final Rx<dynamic> subImageFile3 = Rx<dynamic>(null);
  final Rx<dynamic> subImageFile4 = Rx<dynamic>(null);

  String selectedMain = 'All Statuses';
  String selectedSub = 'All Statuses';
  String selectedSpecific = 'All Statuses';

  showCustomFormDialog(
    context: context,
    title: 'Add New Category',
    confirmText: 'Add Category',
    cancelText: 'Cancel',
    fields: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // সরাসরি _chooseFile কল করো, এখানে আর Obx লাগবে না
            _chooseFile('Main image', mainImageFile),
            const SizedBox(height: 10),
            _chooseFile('Sub image 1', subImageFile1),
            const SizedBox(height: 10),
            _chooseFile('Sub image 2', subImageFile2),
            const SizedBox(height: 10),
            _chooseFile('Sub image 3', subImageFile3),
            const SizedBox(height: 10),
            _chooseFile('Sub image 4', subImageFile4),
            const SizedBox(height: 10),

            _buildField(
              "e.g. Elite Swimming Academy",
              nameController,
              isRequired: true,
            ),
            const SizedBox(height: 10),

            // Dropdown গুলোর জন্য StatefulBuilder
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                final mainList = [
                  'All Statuses',
                  ...controller.itemList
                      .map((item) => item.mainCategory.name)
                      .toSet(),
                ];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Main Category",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    StatusDropdown(
                      dropdownBgColor: Colors.white,
                      focusedBorderColor: Colors.white,
                      value: selectedMain,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedMain = val;
                            selectedSub = 'All Statuses';
                            selectedSpecific = 'All Statuses';
                          });
                        }
                      },
                      statusList: mainList,
                      labelText: 'Select Main Category',
                      borderRadius: 10,
                      fontSize: 15,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Sub Category",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    StatusDropdown(
                      dropdownBgColor: Colors.white,
                      focusedBorderColor: Colors.white,
                      value: selectedSub,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedSub = val;
                            selectedSpecific = 'All Statuses';
                          });
                        }
                      },
                      statusList: [
                        'All Statuses',
                        ...controller.itemList
                            .where(
                              (item) =>
                          selectedMain == 'All Statuses' ||
                              item.mainCategory.name == selectedMain,
                        )
                            .expand(
                              (item) =>
                              item.subCategories.map((sub) => sub.name),
                        )
                            .toSet()
                            .toList(),
                      ],
                      labelText: 'Select Sub Category',
                      borderRadius: 10,
                      fontSize: 15,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Specific Category",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    StatusDropdown(
                      dropdownBgColor: Colors.white,
                      focusedBorderColor: Colors.white,
                      value: selectedSpecific,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => selectedSpecific = val);
                        }
                      },
                      statusList: [
                        'All Statuses',
                        ...controller.itemList
                            .where(
                              (item) =>
                          selectedMain == 'All Statuses' ||
                              item.mainCategory.name == selectedMain,
                        )
                            .expand(
                              (item) => item.subCategories
                              .where(
                                (sub) =>
                            selectedSub == 'All Statuses' ||
                                sub.name == selectedSub,
                          )
                              .expand(
                                (sub) =>
                                sub.specificItems.map((s) => s.name),
                          ),
                        )
                            .toSet()
                            .toList(),
                      ],
                      labelText: 'Select Specific Item',
                      borderRadius: 10,
                      fontSize: 15,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),
            _buildField(
              "E.g. Downtown , 123 Main St",
              locationController,
              isRequired: true,
            ),
            const SizedBox(height: 10),
            _buildField(
              "e.g. 3-5years, 6-12 years, Adults",
              ageGroupController,
            ),
            const SizedBox(height: 10),
            _buildField(
              "e.g. \$100/month Free Trial Available",
              priceController,
            ),
            const SizedBox(height: 10),
            _buildField("e.g. pool, indoor field, gym", facilityController),
            const SizedBox(height: 10),
            _buildField(
              "e.g. Describe the academy, facilities, programs, etc.",
              descriptionController,
              max: 5,
            ),
          ],
        ),
      ),
    ],
    onConfirm: () async {
      if (_formKey.currentState!.validate()) {
        final mainImage = mainImageFile.value;
        final List<dynamic> subImages = [];
        if (subImageFile1.value != null) subImages.add(subImageFile1.value);
        if (subImageFile2.value != null) subImages.add(subImageFile2.value);
        if (subImageFile3.value != null) subImages.add(subImageFile3.value);
        if (subImageFile4.value != null) subImages.add(subImageFile4.value);

        final mainId =
            controller.itemList
                .firstWhereOrNull(
                  (item) => item.mainCategory.name == selectedMain,
            )
                ?.mainCategory
                .id
                .toString() ??
                '';

        final subId =
            controller.itemList
                .expand((item) => item.subCategories)
                .firstWhereOrNull((sub) => sub.name == selectedSub)
                ?.id
                .toString() ??
                '';

        final specificId =
            controller.itemList
                .expand((item) => item.subCategories)
                .expand((sub) => sub.specificItems)
                .firstWhereOrNull((s) => s.name == selectedSpecific)
                ?.id
                .toString() ??
                '';

        final fields = {
          'name': nameController.text.trim(),
          'price': priceController.text.trim(),
          'description': descriptionController.text.trim(),
          'location': locationController.text.trim(),
          'agegroup': ageGroupController.text.trim(),
          'facilities': facilityController.text.trim(),
          'operatingHours': 'Mon-Fri:9 AM - 6 PM',
          'mainCategoryIds': mainId,
          'subCategoryIds': subId,
          'specificItemIds': specificId,
        };

        await listingController.createListing(
          fields: fields,
          mainImage: mainImage,
          subImages: subImages,
        );
      }
    },
  );
}

Widget _buildField(
    String label,
    TextEditingController controller, {
      int? max,
      bool isRequired = false,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      maxLines: max ?? 1,
      controller: controller,
      decoration: InputDecoration(hintText: label),
      validator:
      isRequired
          ? (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      }
          : null,
    ),
  );
}

Widget _chooseFile(String label, Rx<dynamic> pickedFile) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              final file = await FilePickerHelper.pickImageFile();
              if (file != null) {
                pickedFile.value = file;
              }
            },
            icon: const Icon(Icons.upload_file, color: Colors.blue),
            label: Obx(() => Text(
              pickedFile.value != null
                  ? (kIsWeb
                  ? (pickedFile.value as html.File).name
                  : (pickedFile.value as File).path.split('/').last)
                  : 'Choose File',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87),
            )),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    ),
  );
}
