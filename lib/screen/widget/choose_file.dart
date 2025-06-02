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
      required TextEditingController priceController,
      required TextEditingController descriptionController,
      required TextEditingController facilityController,
    }) {
  String selectedStatus = 'All Statuses';
  showCustomFormDialog(
    context: context,
    title: 'Add New Category',
    confirmText: 'Add Category',
    cancelText: 'Cancel',
    fields: [
      _chooseFile('Main image', mainController),
      const SizedBox(height: 10),
      _chooseFile('Sub image 1', subController1),
      const SizedBox(height: 10),
      _chooseFile('Sub image 2', subController2),
      const SizedBox(height: 10),
      _chooseFile('Sub image 3', subController3),
      const SizedBox(height: 20),

      const Text("Name", style: TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(height: 20),
      _buildField("e.g. Elite Swimming Academy", nameController),
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
      SizedBox(height: 10,),
      _buildField("E.g. Downtown , 123 Main St", locationController),
      const SizedBox(height: 10),

      const Text("Age Group", style: TextStyle(fontWeight: FontWeight.w600)),
      _buildField("e.g.3-5years,6-12 years , Adults", locationController),
      const Text("Price", style: TextStyle(fontWeight: FontWeight.w600)),
      _buildField("e.g. \$100/month Free Trial Available , Adults", priceController),

      const Text("facility", style: TextStyle(fontWeight: FontWeight.w600)),
      _buildField("e.g. pool , Indoor field , Gym", priceController),

      const Text("Description", style: TextStyle(fontWeight: FontWeight.w600)),
      _buildField("e.g. Describe the academy , facilities, programs , Etc. ", facilityController,max: 5 ),
    ],
    onConfirm: () {
      print("New Category Added:");
      print("Main: ${mainController.text}");
      print("Sub1: ${subController1.text}");
      print("Sub2: ${subController2.text}");
      print("Sub3: ${subController3.text}");
      print("Name: ${nameController.text}");
      print("Main Category: ${locationController.text}");
      print("Sub Category: ${priceController.text}");
      print("Sport: ${descriptionController.text}");
    },
  );
}


Widget _buildField(String label, TextEditingController controller , {int? max}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      maxLines: max??1,
      controller: controller,
      decoration: InputDecoration(hintText: label),
    ),
  );
}
Widget _chooseFile(String label, TextEditingController controller) {
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
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                controller.text = result.files.single.name;

              }
            },
            icon: const Icon(Icons.upload_file, color: Colors.blue),
            label: Text(
              controller.text.isNotEmpty ? controller.text : 'Main File',
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
}
