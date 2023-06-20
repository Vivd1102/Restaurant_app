import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zensar_recipe_app/controler/splash_screen_controller.dart';
import 'package:zensar_recipe_app/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  static const String id = '/splash_screen';
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: kContainerBackgroundColor,
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_screen.webp',
                height: height,
                width: width,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
