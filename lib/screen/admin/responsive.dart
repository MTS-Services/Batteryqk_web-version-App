import 'package:batteryqk_web/core/asset_path.dart';
import 'package:batteryqk_web/screen/admin/Mobile_layout.dart';
import 'package:batteryqk_web/screen/admin/tablet_layout.dart';
import 'package:batteryqk_web/screen/admin/web_layout.dart';
import 'package:batteryqk_web/screen/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "BatteryQk",
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        logoPath: AssetPath.appLogo,
        actions: [
          IconButton(onPressed: () {},
              icon: Icon(Icons.notifications)
          ),
        ],
      ),
      body: LayoutBuilder(builder:(context, constraints) {
        if(constraints.maxWidth>=1100){

          return WebLayOut();
        }else if(constraints.maxWidth>=650){

          return TabletLayout();
        }else{

          return MobileLayout();
        }
      },),
    );
  }
}
