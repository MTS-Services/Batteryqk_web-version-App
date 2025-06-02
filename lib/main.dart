import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'batteryqk.dart';
void main() {
  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    builder: (context, child) => Batteryqk(),
  ));
}