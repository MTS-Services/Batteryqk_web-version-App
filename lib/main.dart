import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'batteryqk.dart';
import 'controller/listing_controller.dart';
void main() {
  Get.put(ListingController());
  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    builder: (context, child) => Batteryqk(),
  ));
}