import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var showSpinner = false.obs;

  var emailController = TextEditingController();
  var passwdController = TextEditingController();

  getFirebaseInstance() {
    final _auth = FirebaseAuth.instance;
    return _auth;
  }


  @override
  void onInit() {
    super.onInit();
  }

}
