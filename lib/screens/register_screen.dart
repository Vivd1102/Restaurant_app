import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'search_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/register_screen';


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

// _RegisterScreenState class, extends State
class _RegisterScreenState extends State<RegisterScreen> {
// Initialize FirebaseAuth instance
  final _auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// Initialize required variables
  late String email;
  late String password;
  bool showSpinner = false;
  String errorMessage = '';

// Override build method, returns a Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  kWelcomeScreenRegister,
                  style: kLoginScreenTitleStyle,
                ),
              ),
              SizedBox(height: 16.0),
// Email TextField widget
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: kLoginTextFieldEmail,
                  border: OutlineInputBorder(),
                  hintText: 'Enter Username',
                  icon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'User name cant be blank';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
// Password TextField widget
              TextFormField(
                  controller: passwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: kLoginTextFieldPassword,
                    hintText: 'Enter password',
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email id cant be blank';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: 200,height: 60,
                child: ElevatedButton(
                  onPressed: () async {


                    try {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          showSpinner = true;
                        });
                        // Create user with email and password
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    // Navigate to HomeScreen
                        Navigator.pushNamed(context, Routes.category);
                      }

                    } on FirebaseAuthException catch (e) {
                  // Set error message if there is a FirebaseAuthException
                      setState(() {
                        showSpinner = false;
                        errorMessage = e.message!;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(kWelcomeScreenRegister,style: kLoginScreenButStyle),
                ),
              ),
              SizedBox(height: 8.0),
              // Show CircularProgressIndicator if showSpinner is true
              if (showSpinner)
                Center(
                  child: CircularProgressIndicator(),
                ),
              // Show error message if errorMessage is not empty
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
