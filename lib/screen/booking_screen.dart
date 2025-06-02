import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/screen/widget/CustomeDatePicker.dart';
import 'package:batteryqk_web/screen/widget/custom_dropdown_button.dart';
import 'package:batteryqk_web/screen/widget/custom_header_text.dart';
import 'package:batteryqk_web/screen/widget/dilog_utils.dart';
import 'package:batteryqk_web/screen/widget/responsive_Header_Row.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<Map<String, dynamic>> headerData = [
    {'key': 'id', 'label': 'ID'},
    {'key': 'User', 'label': 'User'},
    {'key': 'Academy', 'label': 'Academy'},
    {'key': 'Date & Time', 'label': 'Date & Time'},
    {'key': 'Status', 'label': 'Status'},
    {'key': 'Payment', 'label': 'Payment', 'icon': Icons.star_border},
    {
      'key': 'actions',
      'label': 'Actions',
      'icons': [Icons.edit, Icons.delete, Icons.visibility],
    },
  ];

  final dateController = TextEditingController();
  final TextEditingController _paidTEController = TextEditingController();
  final TextEditingController _unpaidTEController = TextEditingController();

  String selectedStatus = 'All Statuses';
  String selectedAcademy = 'Elite Swimming Academy';

  double getFontSize(double width, {bool isHeader = false}) {
    if (width < 600) return isHeader ? 18 : 14;
    if (width < 1024) return isHeader ? 20 : 16;
    return isHeader ? 22 : 18;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rowFontSize = getFontSize(screenWidth);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CustomHeadingText(text: 'User Management'),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;

                  final firstDropdown = StatusDropdown(
                    dropdownBgColor: Colors.white,
                    focusedBorderColor: Colors.white,
                    value: selectedStatus,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedStatus = val);
                    },
                    statusList: ['All Statuses', 'Confirmed', 'Pending', 'Canceled'],
                    hintText: 'Choose status',
                    labelText: 'Filter by Status',
                    borderRadius: 10,
                    fontSize: 15,
                  );

                  final secondDropdown = StatusDropdown(
                    dropdownBgColor: Colors.white,
                    value: selectedAcademy,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedAcademy = val);
                    },
                    statusList: [
                      'Elite Swimming Academy',
                      'Champions Football Academy',
                      'Hoops Basketball Center',
                      'Little Stars Nursery'
                    ],
                    hintText: 'Choose academy',
                    labelText: 'Filter by Academy',
                    borderRadius: 10,
                    fontSize: 15,
                  );

                  final dataPicker = CustomDatePicker(
                    controller: dateController,
                    labelText: 'Booking Date',
                    initialDate: DateTime.now(),
                  );

                  final elevatedButton = ElevatedButton(
                    onPressed: () {
                      // Filter logic
                    },
                    child: const Text("Apply Filter"),
                  );

                  return isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      firstDropdown,
                      const SizedBox(height: 10),
                      secondDropdown,
                      const SizedBox(height: 10),
                      dataPicker,
                      const SizedBox(height: 10),
                      elevatedButton,
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(child: firstDropdown),
                      const SizedBox(width: 10),
                      Expanded(child: secondDropdown),
                      const SizedBox(width: 10),
                      Expanded(child: dataPicker),
                      const SizedBox(width: 10),
                      elevatedButton,
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
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
                            email: 'Elite Swimming Academy',
                            joinDate: '2023-01-01',
                            bookings: 'Confirmed',
                            onPointsIconPressed: List.generate(
                              4,
                                  (_) => () => print('Star pressed'),
                            ),
                            actions: '',
                            actionIcons: [
                              Icons.edit_calendar_outlined,
                              Icons.delete,
                            ],
                            onActionIconPressed: [
                                  () {

                                    String selectedStatus = 'All Statuses';
                                    final selectStatusDropdown = StatusDropdown(
                                      dropdownBgColor: Colors.white,
                                      focusedBorderColor: Colors.white,
                                      value: selectedStatus,
                                      onChanged: (val) {
                                        if (val != null) setState(() => selectedStatus = val);
                                      },
                                      statusList: ['All Statuses', 'Confirmed', 'Pending', 'Canceled'],
                                      hintText: 'Choose status',
                                      labelText: 'Status',
                                      borderRadius: 10,
                                      fontSize: 15,
                                    );

                                    String selectPainUnpaidStatus = 'payment Status';
                                    final selectDropdown = StatusDropdown(
                                      dropdownBgColor: Colors.white,
                                      focusedBorderColor: Colors.white,
                                      value: selectPainUnpaidStatus,
                                      onChanged: (val) {
                                        if (val != null) setState(() => selectPainUnpaidStatus = val);
                                      },
                                      statusList: ['payment Status', "paid" , 'Unpaid'],
                                      hintText: 'Choose status',
                                      labelText: 'payment Status',
                                      borderRadius: 10,
                                      fontSize: 15,
                                    );
                                showCustomFormDialog(
                                  context: context,
                                  title: 'Edit',
                                  fields: [
                                    selectStatusDropdown,
                                    SizedBox(height: 10,),
                                    selectDropdown
                                  ],
                                  confirmText: "Edit",
                                  cancelText: "Cancel",
                                  onConfirm: () {},
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
                                  onConfirm: () {},
                                );
                              },
                            ],
                            points: 'Unpaid',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _paidTEController.dispose();
    _unpaidTEController.dispose();
    super.dispose();
  }
}
