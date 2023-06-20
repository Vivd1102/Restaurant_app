import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zensar_recipe_app/components/navbar.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = '/settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

// Define the state for the settings screen
class _SettingsScreenState extends State<SettingsScreen> {
// Build the settings screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text(kSettingsText,style: kFavouriteScreenTitleStyle), automaticallyImplyLeading: false,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Display screen title

          // Display appearance options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kSettingsScreenAppearanceTxt,
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
              // Display dark mode switch
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(kSettingsScreenDrkMode,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    SizedBox(width:100,
                      child: Switch(
                        value: AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.dark,
                        onChanged: (value) {
                          if (value) {
                            AdaptiveTheme.of(context).setDark();
                          } else {
                            AdaptiveTheme.of(context).setLight();
                          }
                        },
                      ),
                    ),
                  ],

                ),
                SizedBox(height: 5.0),
              ],
            ),
          ),
      // Display legal options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kLegalTxt,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
        // Display button to privacy policy
                ElevatedButton(
                  child: Text(kSettingsPrivacyPolicy,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    const url = kDummyPrivacyPolicy;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                SizedBox(height: 8.0),
// Display button to license
                ElevatedButton(
                  child: Text(kSettingsLicense,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  onPressed: () async {
                    const url = kDummyLicense;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                SizedBox(height: 8.0),
// Display button to log out
                ElevatedButton(
                  child: Text(kSettingsLogout,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
// Display the bottom navigation bar
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.category);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.search);
          }else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.favorites);
          }
        },
      ),
    );
  }
}
