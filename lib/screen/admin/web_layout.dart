
import 'package:flutter/material.dart';

import '../booking_screen.dart';
import '../listing_screen.dart';
import '../review_screen.dart';
import '../user_screen.dart';
import '../widget/custom_header_text.dart';
import '../widget/custom_tab_bar.dart';

class WebLayOut extends StatefulWidget {
  const WebLayOut({super.key});

  @override
  State<WebLayOut> createState() => _WebLayOutState();
}

class _WebLayOutState extends State<WebLayOut> with SingleTickerProviderStateMixin {
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
    _tabController.dispose(); // Always dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const CustomHeadingText(text: 'Admin Dashboard'),
          CustomTabBar(controller: _tabController, tabs: columnTabs),
          const SizedBox(height: 10),
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
