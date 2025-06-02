import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/screen/widget/custom_header_text.dart';
import 'package:batteryqk_web/screen/widget/responsive_Header_Row.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Map<String, dynamic>> headerData = [
    {'key': 'id', 'label': 'ID'},
    {'key': 'User', 'label': 'User'},
    {'key': 'Listing', 'label': 'Listing'},
    {'key': 'Rating', 'label': 'date'},
    {'key': 'Comment', 'label': 'Comment'},
    {'key': 'Date', 'label': 'Rating'},
    {'key': 'Status', 'label': 'Status'},
    {
      'key': 'actions',
      'label': 'Actions',
      'icons': [Icons.edit, Icons.delete, Icons.visibility],
    },
  ];

  double getFontSize(double width, {bool isHeader = false}) {
    if (width < 600) {
      return isHeader ? 12: 14;
    } else if (width < 1024) {
      return isHeader ? 14 : 16;
    } else {
      return isHeader ? 16 : 18;
    }
  }
  final TextEditingController _nameTEController =TextEditingController();
  final TextEditingController _emailTEController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rowFontSize = getFontSize(screenWidth);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
          const CustomHeadingText(text: 'Review Management'),
            ResponsiveHeaderRow(
              hadingColor: AppColors.tabColor,
              id: headerData[0]['label'],
              name: headerData[1]['label'],
              email: headerData[2]['label'],
              joinDate: headerData[3]['label'],
              bookings: headerData[4]['label'],
              points: headerData[5]['label'],
              status: headerData[6]['label'],
              actions: headerData[7]['label'],
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
                    name: 'Swimming',
                    email: 'Elite Swimming Academy',
                    joinDate: '1/2/2000',
                    bookings: 'All Ages',
                    status: index % 2 == 0 ? 'Active' : 'Inactive',
                    pointsIcons: [
                      Icons.star,
                      Icons.star,
                      Icons.star,
                      Icons.star
                    ],
                    onPointsIconPressed: List.generate(
                      4,
                          (_) => () => print('Star icon pressed'),
                    ),
                    actions: '',
                    actionIcons: [
                      Icons.visibility,
                      Icons.edit_calendar_outlined,
                      Icons.delete
                    ],
                    onActionIconPressed: [
                          () {

                      },
                          () {


                      }
                    ],
                    points: '',
                    fontSize: rowFontSize,
                    actionIconColors: [
                      Colors.blueAccent,
                      Colors.yellow,
                      Colors.red
                    ],
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
