import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
// Define variables to keep track of the button's title, color, and onPressed function
  final String title;
  final Color color;
  final Function onPressed;

// Construct the widget
  RoundedButton(
      {required this.title, required this.color, required this.onPressed});

// Build the rounded button widget
  @override
  Widget build(BuildContext context) {
    return Padding(
// Set the padding around the button
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
// Set the material elevation, color, and border radius
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
// Define the onPressed function and button size
          onPressed: onPressed(),
          minWidth: 200.0,
          height: 42.0,
// Display the button's title text
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
