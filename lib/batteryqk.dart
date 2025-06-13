import 'package:batteryqk_web/core/app_colors.dart';
import 'package:batteryqk_web/screen/admin/responsive.dart';
import 'package:batteryqk_web/screen/sing_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Batteryqk extends StatelessWidget {
  const Batteryqk({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => SignInScreen()),
        GetPage(name: '/Responsive', page: () =>Responsive()),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: _buildElevatedButtonThemeData(),
        inputDecorationTheme: _buildInputDecorationTheme(),
      ),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
          filled: true,
         fillColor: Colors.white,
         outlineBorder: BorderSide(color: Colors.grey.shade400),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
           borderRadius: BorderRadius.circular(10)
         ),
         enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
             borderRadius: BorderRadius.circular(10)
         ),
         hintStyle: TextStyle(
           color: Colors.grey.shade400,
         ),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.tabColor),
              borderRadius: BorderRadius.circular(10),
          )
      );
  }
}
