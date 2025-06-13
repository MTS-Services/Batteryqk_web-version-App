import 'package:batteryqk_web/controller/all_user_controller.dart';
import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/data/model/updateModel.dart';
import 'package:batteryqk_web/screen/widget/custom_header_text.dart';
import 'package:batteryqk_web/screen/widget/dilog_utils.dart';
import 'package:batteryqk_web/screen/widget/responsive_Header_Row.dart';
import 'package:batteryqk_web/screen/widget/show_Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/service/get_all_user_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AllUserController allUserController = Get.put(AllUserController());

  final TextEditingController _fnameTEController = TextEditingController();
  final TextEditingController _lnameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();

  final List<Map<String, dynamic>> headerData = [
    {'key': 'id', 'label': 'ID'},
    {'key': 'name', 'label': 'Name'},
    {'key': 'email', 'label': 'Email'},
    {'key': 'joinDate', 'label': 'Join Date'},
    {'key': 'bookings', 'label': 'Bookings'},
    {
      'key': 'actions',
      'label': 'Actions',
      'icons': [Icons.edit, Icons.delete],
    },
  ];

  double getFontSize(double width, {bool isHeader = false}) {
    if (width < 600) return isHeader ? 18 : 14;
    if (width < 1024) return isHeader ? 20 : 16;
    return isHeader ? 22 : 18;
  }

  @override
  void dispose() {
    _fnameTEController.dispose();
    _lnameTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rowFontSize = getFontSize(screenWidth);

    return Obx(() {
      if (allUserController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (allUserController.userList.isEmpty) {
        return const Center(child: Text("User Not Found", style: TextStyle(fontSize: 15)));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomHeadingText(text: 'User Management'),
          ResponsiveHeaderRow(
            pointsFlex: 0,
            hadingColor: AppColors.tabColor,
            id: headerData[0]['label'],
            name: headerData[1]['label'],
            email: headerData[2]['label'],
            joinDate: headerData[3]['label'],
            bookings: headerData[4]['label'],
            actions: headerData[5]['label'],
            radius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            fontSize: 18,
            points: '',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allUserController.userList.length,
              itemBuilder: (context, index) {
                final user = allUserController.userList[index];
                final isLast = index == allUserController.userList.length - 1;

                return ResponsiveHeaderRow(
                  hadingColor: Colors.white,
                  pointsFlex: 0,
                  id: user.id.toString(),
                  name: "${user.fname} ${user.lname}",
                  email: user.email,
                  joinDate: DateTime.parse(user.createdAt).toLocal().toString().split(' ')[0],
                  bookings: user.totalRewardPoints >= 100
                      ? user.highestRewardCategory
                      : user.totalRewardPoints.toString(),
                  actions: '',
                  actionIcons: [Icons.edit_calendar_outlined, Icons.delete],
                  onActionIconPressed: [
                        () {
                      _fnameTEController.text = user.fname;
                      _lnameTEController.text = user.lname;
                      _emailTEController.text = user.email;

                      showCustomFormDialog(
                        context: context,
                        title: 'Edit',
                        fields: [
                          _buildField("First Name", _fnameTEController),
                          _buildField("Last Name", _lnameTEController),
                          _buildField("Email", _emailTEController),
                        ],
                        confirmText: "Edit",
                        cancelText: "Cancel",
                        onConfirm: () {
                          userUpdate(user.id);
                        },
                      );
                    },
                        () {
                      showCustomFormDialog(
                        context: context,
                        title: 'Delete',
                        fields: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Are you sure you want to delete this user?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                        confirmText: "Delete",
                        cancelText: "Cancel",
                        onConfirm: () {
                          deleteUsers(user.id, index);
                        },
                      );
                    }
                  ],
                  points: '',
                  fontSize: rowFontSize,
                  actionIconColors: [Colors.yellow, Colors.red],
                  radius: isLast
                      ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                      : BorderRadius.zero,
                );
              },
            ),
          ),
        ],
      );
    });
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

  void deleteUsers(int id, int index) async {
    final user = allUserController.userList[index];
    final isDeleted = await UserService.deleteUser(user.id);

    if (isDeleted) {
      allUserController.userList.removeAt(index);
      showSnackbar("Deleted", "User deleted successfully.");
    } else {
      showSnackbar("Error", "Failed to delete user.");
    }
  }

  void userUpdate(int id) async {
    final fname = _fnameTEController.text.trim();
    final lname = _lnameTEController.text.trim();
    final email = _emailTEController.text.trim();

    if (email.isEmpty || fname.isEmpty || lname.isEmpty) {
      showSnackbar("Error", "Please fill all fields.");
      return;
    }

    final userUpdated = UpdateModel(fname: fname, lname: lname, email: email);
    final isUpdate = await UserService.userUpdate(id, userUpdated);

    if (isUpdate) {
      showSnackbar("Success", "User updated successfully.");
      allUserController.fetchAllUsers();
    } else {
      showSnackbar("Error", "Failed to update user.");
    }
  }
}
