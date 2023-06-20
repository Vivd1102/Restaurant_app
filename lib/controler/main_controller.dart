import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
class MainController extends GetxController{

  @override
  void onInit() async{
    super.onInit();
    initFireBase();
  }

  Future<void> initFireBase() async {
    Platform.isAndroid?  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: kAppKey,
        appId: kAppId,
        messagingSenderId:kMessagingSenderId,
        projectId: kProjectId,
      ),
    ):await Firebase.initializeApp();
  }
}