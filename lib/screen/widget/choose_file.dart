import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'custom_dropdown_button.dart';
import 'dilog_utils.dart';

void chooseFileBox(
    BuildContext context, {
      required TextEditingController mainController,
      required TextEditingController subController1,
      required TextEditingController subController2,
      required TextEditingController subController3,
      required TextEditingController subController4,
      required TextEditingController nameController,
      required TextEditingController locationController,
      required TextEditingController ageGroupController,
      required TextEditingController priceController,
      required TextEditingController descriptionController,
      required TextEditingController facilityController,
    }) {
  final _formKey = GlobalKey<FormState>();
  String selectedStatus = 'All Statuses';
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
            _chooseFile('Main image', mainController),
            const SizedBox(height: 10),
            _chooseFile('Sub image 1', subController1),
            const SizedBox(height: 10),
            _chooseFile('Sub image 2', subController2),
            const SizedBox(height: 10),
            _chooseFile('Sub image 3', subController3),
            const SizedBox(height: 10),
            _chooseFile('Sub image 4', subController4),
            const SizedBox(height: 10),
            const Text("Name", style: TextStyle(fontWeight: FontWeight.w600)),
            _buildField("e.g. Elite Swimming Academy", nameController, isRequired: true),
            const SizedBox(height: 10),
            const Text("Main Category", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return StatusDropdown(
                  dropdownBgColor: Colors.white,
                  focusedBorderColor: Colors.white,
                  value: selectedStatus,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedStatus = val);
                    }
                  },
                  statusList: ['All Statuses', 'Confirmed', 'Pending', 'Canceled'],
                  hintText: 'Choose status',
                  labelText: 'Filter by Status',
                  borderRadius: 10,
                  fontSize: 15,
                );
              },
            ),
            const SizedBox(height: 10),
            const Text("Location", style: TextStyle(fontWeight: FontWeight.w600)),
            _buildField("E.g. Downtown , 123 Main St", locationController, isRequired: true),
            const SizedBox(height: 10),
            const Text("Age Group", style: TextStyle(fontWeight: FontWeight.w600)),
            _buildField("e.g. 3-5years, 6-12 years, Adults", ageGroupController),
            const SizedBox(height: 10),
            const Text("Price", style: TextStyle(fontWeight: FontWeight.w600)),
            _buildField("e.g. \$100/month Free Trial Available", priceController),
            const SizedBox(height: 10),
            const Text("Facility", style: TextStyle(fontWeight: FontWeight.w600)),
            _buildField("e.g. pool, indoor field, gym", facilityController),
            const SizedBox(height: 10),
            const Text("Description", style: TextStyle(fontWeight: FontWeight.w600)),
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

      }
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
      validator: isRequired
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

Widget _chooseFile(String label, TextEditingController controller) {
  return StatefulBuilder(
    builder: (context, setState) {
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
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null && result.files.single.path != null) {
                    controller.text = result.files.single.path!;
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.upload_file, color: Colors.blue),
                label: Text(
                  controller.text.isNotEmpty
                      ? controller.text.split('/').last
                      : 'Choose File',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87),
                ),
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
    },
  );
}


