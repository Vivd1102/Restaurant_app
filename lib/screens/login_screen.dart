import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zensar_recipe_app/controler/login_controller.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller =  Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

// Variables for user email, password and spinner visibility
  late String email;
  late String password;
  bool showSpinner = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
// Login Screen title
              Center(
                child: Text(
                  kWelcomeScreenLogin,
                  style: kLoginScreenTitleStyle,
                ),
              ),
              SizedBox(height: 16.0),

// Textfield for user email input
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: kLoginTextFieldEmail,
                  border: OutlineInputBorder(),
                  hintText: kUserNameBlankHint,
                  icon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return kUserNameBlankErr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Textfield for user password input
              TextFormField(
                  controller: controller.passwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: kLoginTextFieldPassword,
                    hintText: kPwBlankHint,
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return kUserEmailIdBlankErr;
                    }
                    return null;
                  }),
              SizedBox(height: 16.0),
// Elevated button for user to log in
              SizedBox(
                width: 200.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () async {
// Show spinner and clear error message
                    try {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                          errorMessage = '';
                        });
                        // Attempt to sign in user with email and password
                        final userCredential =
                            await controller.getFirebaseInstance().signInWithEmailAndPassword(
                                email: email, password: password);
                          // If successful, navigate to Category screen
                          User? user = userCredential.user;
                          if (user != null) {
                            print('Logged in as ${user.email}');
                            Navigator.pushNamed(context, Routes.category);
                          }
                        // Hide spinner
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      // Handle error if login attempt fails
                      setState(() {
                        showSpinner = false;
                        if (e.code == 'wrong-password') {
                          errorMessage = kLoginErrorFirbasePW;
                        } else {
                          errorMessage = kLoginErrorFirbase;
                        }
                      });
                    } catch (e) {
                      // Handle other errors
                      setState(() {
                        showSpinner = false;
                        errorMessage = kLoginErrorFirbase;
                      });
                    }
                  },
                  child: Text(
                    kLoginScreenButon,
                    style: kLoginScreenButStyle,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Show spinner while user logs in
              if (showSpinner)
                Center(
                  child: CircularProgressIndicator(),
                ),
              // Show error message if login attempt fails
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
