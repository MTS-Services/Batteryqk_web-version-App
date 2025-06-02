import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/screen/widget/custom_header_text.dart';
import 'package:batteryqk_web/screen/widget/dilog_utils.dart';
import 'package:batteryqk_web/screen/widget/responsive_Header_Row.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<Map<String, dynamic>> headerData = [
    {'key': 'id', 'label': 'ID'},
    {'key': 'name', 'label': 'Name'},
    {'key': 'email', 'label': 'Email'},
    {'key': 'joinDate', 'label': 'Join Date'},
    {'key': 'bookings', 'label': 'Bookings'},
    {'key': 'points', 'label': 'Points',},
    {
      'key': 'actions',
      'label': 'Actions',
      'icons': [Icons.edit, Icons.delete, Icons.visibility],
    },
  ];
  double getFontSize(double width, {bool isHeader = false}) {
    if (width < 600) {
      return isHeader ? 18 : 14;
    } else if (width < 1024) {
      return isHeader ? 20 : 16;
    } else {
      return isHeader ? 22 : 18;
    }
  }
  final TextEditingController _nameTEController =TextEditingController();
  final TextEditingController _emailTEController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final rowFontSize = getFontSize(screenWidth);

    return Scaffold(
      body: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomHeadingText(text: 'User Management '),
          ResponsiveHeaderRow(
            hadingColor: AppColors.tabColor,
            id: headerData[0]['label'],
            name: headerData[1]['label'],
            email: headerData[2]['label'],
            joinDate: headerData[3]['label'],
            bookings: headerData[4]['label'],
            points: headerData[5]['label'],
            actions: headerData[6]['label'],
            radius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            fontSize: 18,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final bool isLast = index == 9;

                return ResponsiveHeaderRow(
                  hadingColor: Colors.white,
                  id: '00${index + 1}',
                  name: 'Alice',
                  email: 'alice@example.com',
                  joinDate: '2023-01-01',
                  bookings: '10',
                  pointsIcons: [Icons.star, Icons.star, Icons.star, Icons.star],
                  onPointsIconPressed: List.generate(4,
                        (_) => () => print('Star icon pressed'),
                  ),
                  actions: '',
                  actionIcons: [Icons.edit_calendar_outlined, Icons.delete],
                  onActionIconPressed: [
                        () {
                          showCustomFormDialog(
                              context: context,
                              title: 'Edit',
                              fields: [
                                _buildField("Name" , _nameTEController),
                                _buildField("Email" , _emailTEController)
                              ],
                              confirmText: "Edit",
                              cancelText: "Cancel",
                            onConfirm: (){
                              
                            }
                          );
                        },
                          () {
                            showCustomFormDialog(
                              context: context,
                              title: 'Delete',
                              fields: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(
                                    "Are you sure you want to delete this item?",
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
                                // delete logic here
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
      ),
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
  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _nameTEController.dispose();
  }
}
