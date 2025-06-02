import 'package:batteryqk_web/screen/booking_screen.dart';
import 'package:batteryqk_web/screen/listing_screen.dart';
import 'package:batteryqk_web/screen/review_screen.dart';
import 'package:batteryqk_web/screen/user_screen.dart';
import 'package:flutter/material.dart';
import '../widget/custom_header_text.dart';
import '../widget/custom_tab_bar.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> columnTabs = [
    "User",
    "Booking",
    "Listing",
    "Reviews",
  ];

  final List<Widget> allScreen = [
    UserScreen(),
    BookingScreen(),
    ListingScreen(),
    ReviewScreen()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: columnTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomHeadingText(text: 'Admin Dashboard'),
          CustomTabBar(controller: _tabController, tabs: columnTabs, ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: allScreen
            ),
          ),

        ],
      ),
    );
  }
}
