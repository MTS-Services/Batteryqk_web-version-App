import 'package:batteryqk_web/controller/listing_controller.dart';
import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/screen/widget/add_category.dart';
import 'package:batteryqk_web/screen/widget/background_widget.dart';
import 'package:batteryqk_web/screen/widget/choose_file.dart';
import 'package:batteryqk_web/screen/widget/custom_header_text.dart';
import 'package:batteryqk_web/screen/widget/dilog_utils.dart';
import 'package:batteryqk_web/screen/widget/responsive_header_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/getListingController.dart';
import '../controller/item_controller.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

final ItemController controller = Get.put(ItemController());
final GetListingController listingController = Get.put(GetListingController());

class _ListingScreenState extends State<ListingScreen> {
  final TextEditingController mainController = TextEditingController();
  final TextEditingController subController1 = TextEditingController();
  final TextEditingController subController2 = TextEditingController();
  final TextEditingController subController3 = TextEditingController();
  final TextEditingController subController4 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sportCategoryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController facilityController = TextEditingController();
  final TextEditingController ageGroupController = TextEditingController();

  final List<Map<String, dynamic>> headerData = [
    {'key': 'id', 'label': 'ID'},
    {'key': 'Name', 'label': 'Name'},
    {'key': 'Category', 'label': 'Age Group'},
    {'key': 'Location', 'label': 'Location'},
    {'key': 'Age Group', 'label': 'Facilities'},
    {'key': 'Rating', 'label': 'Opening Hours'},
    {
      'key': 'actions',
      'label': 'Actions',
      'icons': [Icons.edit, Icons.delete, Icons.visibility],
    },
  ];

  double getFontSize(double width, {bool isHeader = false}) {
    if (width < 600) return isHeader ? 18 : 14;
    if (width < 1024) return isHeader ? 20 : 16;
    return isHeader ? 22 : 18;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rowFontSize = getFontSize(screenWidth);
    final data = listingController.itemList;
    print("data=====> $data");

    return BackgroundWidget(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final heading = const CustomHeadingText(
                  text: 'Listings Management',
                );
                final isMobile = constraints.maxWidth < 600;
                final buttons = Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Obx(
                      () =>
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton.icon(
                                onPressed: () => openAddCategoryDialog(context),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Categories'),
                              ),
                    ),
                    Obx(
                      () =>
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                label: const Text('New Listing'),
                                onPressed:
                                    () => chooseFileBox(
                                      context,
                                      mainController: mainController,
                                      subController1: subController1,
                                      subController2: subController2,
                                      subController3: subController3,
                                      subController4: subController4,
                                      nameController: nameController,
                                      locationController: locationController,
                                      priceController: priceController,
                                      descriptionController:
                                          sportCategoryController,
                                      facilityController: facilityController,
                                      ageGroupController: ageGroupController,
                                    ),
                              ),
                    ),
                  ],
                );
                return isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [heading, const SizedBox(height: 10), buttons],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [heading, buttons],
                    );
              },
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            Obx(
              () =>
                  listingController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final listing = data[index];
                          final isLast = index == data.length - 1;
                          final location =
                              listing.location.isNotEmpty
                                  ? listing.location.first
                                  : 'No Location';
                          final ageGroup =
                              listing.agegroup.isNotEmpty
                                  ? listing.agegroup.first
                                  : 'No Age Group';

                          return ResponsiveHeaderRow(
                            hadingColor: Colors.white.withAlpha(230),
                            id: listing.id.toString(),
                            name: listing.name,
                            email:
                                (listing.selectedMainCategories.isNotEmpty &&
                                        index <
                                            listing
                                                .selectedMainCategories
                                                .length)
                                    ? listing
                                            .selectedMainCategories[index]
                                            .name ??
                                        'No Name'
                                    : 'No Categories',
                            joinDate: location,
                            bookings: ageGroup,
                            status: listing.operatingHours.first,
                            onPointsIconPressed: List.generate(
                              4,
                              (_) => () => print('Star icon pressed'),
                            ),
                            actions: '',
                            actionIcons: [
                              Icons.visibility,
                              Icons.edit_calendar_outlined,
                              Icons.delete,
                            ],
                            onActionIconPressed: [
                              () => showCustomFormDialog(
                                context: context,
                                title: 'Delete',
                                fields: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
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
                                  // Handle delete action
                                },
                              ),
                              () =>
                                  controller.isLoading.value
                                      ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                      : chooseFileBox(
                                        context,
                                        mainController: mainController,
                                        subController1: subController1,
                                        subController2: subController2,
                                        subController3: subController3,
                                        subController4: subController4,
                                        nameController: nameController,
                                        locationController: locationController,
                                        priceController: priceController,
                                        descriptionController:
                                            sportCategoryController,
                                        facilityController: facilityController,
                                        ageGroupController: ageGroupController,
                                      ),
                              () => showCustomFormDialog(
                                context: context,
                                title: 'Delete',
                                fields: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
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
                                  // Handle delete action
                                },
                              ),
                            ],
                            points: '',
                            fontSize: rowFontSize,
                            actionIconColors: [
                              Colors.blueAccent,
                              Colors.yellow,
                              Colors.red,
                            ],
                            radius:
                                isLast
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

  @override
  void dispose() {
    super.dispose();
    mainController.dispose();
    subController1.dispose();
    subController2.dispose();
    subController3.dispose();
    subController4.dispose();
    nameController.dispose();
    sportCategoryController.dispose();
    locationController.dispose();
    priceController.dispose();
    facilityController.dispose();
    ageGroupController.dispose();
  }
}
