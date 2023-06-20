import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zensar_recipe_app/controler/main_controller.dart';
import 'package:zensar_recipe_app/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MainController mc = Get.put(MainController());
  mc.initFireBase();

// Run the app
  runApp(HomePage());
}


