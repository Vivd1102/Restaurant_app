import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/screens/category_details.dart';
import 'package:zensar_recipe_app/screens/category_screen.dart';
import 'package:zensar_recipe_app/screens/splash_screen.dart';
import 'package:zensar_recipe_app/utils/constants.dart';

import 'favorites_screen.dart';
import 'search_screen.dart';
import 'login_screen.dart';
import 'recipe_screen.dart';
import 'register_screen.dart';
import 'settings_screen.dart';
import 'welcome_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        brightness: kBrightness,
        primarySwatch: kOrange,
      ),
      dark: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amberAccent.shade100,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        brightness: kDark,
        primarySwatch: kOrange,
      ),
      initial: AdaptiveThemeMode.light,
      // Setting the initial theme mode to light
      builder: (theme, darkTheme) => GetMaterialApp(
        title: kAppTitle,
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash_screen,
        // Setting the initial route to the welcome screen
        routes: {
// routes for each screen
          Routes.splash_screen: (context) => SplashScreen(),
          Routes.category: (context) => CategoryScreen(),
          Routes.category_details: (context) => CategoryDetailsScreen(
              mealsCategory:
                  ModalRoute.of(context)!.settings.arguments as dynamic),
          Routes.welcome: (context) => WelcomeScreen(),
          Routes.login: (context) => LoginScreen(),
          Routes.register: (context) => RegisterScreen(),
          Routes.search: (context) => SearchScreen(),
          Routes.recipe: (context) => RecipeScreen(
              recipe: ModalRoute.of(context)!.settings.arguments as dynamic),
          Routes.settngs: (context) => SettingsScreen(),
          Routes.favorites: (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
