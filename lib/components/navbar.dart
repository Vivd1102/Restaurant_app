import 'package:flutter/material.dart';
import 'package:zensar_recipe_app/utils/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
// Define variables to keep track of selected index and onItemTapped function
  final int selectedIndex;
  final Function(int) onItemTapped;

// Construct the widget
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

// Build the bottom navigation bar widget
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: kBottomNavCatTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: kBottomNavSearchTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: kBottomNavFavTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: kBottomNavSettingsTitle,
        ),
      ],
// Set the current selected index and selected item color
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
// Make the unselected labels transparent
      selectedLabelStyle: TextStyle(
          fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
          fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
// Define the onTap function
      onTap: onItemTapped,
    );
  }
}
