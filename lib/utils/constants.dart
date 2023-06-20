import 'package:flutter/material.dart';

const String kAppTitle = "Zensar Recipe App";
const String kWelComeScreenTitle = "Welcome to Zensar Recipe App";
const String kWelcomeScreenSubTitle = "";
const String kWelcomeScreenRegister = 'Register';
const String kWelcomeScreenRegisterAlready = 'Already registered?';
const String kWelcomeScreenLogin = 'Login';
const String kLoginTextFieldEmail = 'Email';
const String kLoginTextFieldPassword = 'Password';
const String kLoginScreenButon = 'Log In';
const String kSettingsScreenDrkMode = 'Dark mode';
const String kSettingsScreenTitle ='Settings';
const String kSettingsScreenAppearanceTxt ='Appearance';
const String kSettingsPrivacyPolicy='Privacy Policy';
const String kSettingsLicense='License';
const String kSettingsLogout = 'Log Out';
const String kFavouriteRecipeText =  'Favorites Recipes';
const String kFavouriteRecipeSubText =  'Find Your Favorites Here !';
const String kNoFavouriteRecipeText =  'No favorite recipes';
const String kRandomMealText =  'Random Meal';
const String kSettingsText =  'Settings';
const String kSearchScreenText =  'Find Your Meals Randomly';
const String kSearchForaMealText =  'Search for a meal!';
const String kSearchNoMeal =  'No results found.';
const String kLoginErrorFirbasePW =  'Incorrect password';
const String kLoginErrorFirbase =  'Could not log in. Please try again later.';
const String kUserNameBlankErr = 'User name cant be blank';
const String kUserEmailIdBlankErr = 'email id cant be blank';
const String kPwBlankHint = 'Enter password';
const String kUserNameBlankHint = 'Enter User Name';
const String kLegalTxt = 'Legal';
const String kSearchSubTitle ='Search your tasty food!';
const String kSearchHintTxt = 'Search any meals, ingredient, or category';
const String kCategoryTitle = "Category Menu";
const String kCategoryDetailsTitle = "Category Details";
const String kBottomNavCatTitle= "Categories";
const String kBottomNavFavTitle= "Favorites";
const String kBottomNavSearchTitle= "Search";
const String kBottomNavSettingsTitle= "Settings";
const String kSplashText= "Zensar Recipe App";

//firebase constants
const String kAppId = "1:672370746332:android:cb90b6d9d89d776a2b6519";
const String kAppKey = "AIzaSyA8kFwMnaNtO348jPL4xVTbgUZu-yF4ULg";
const String kMessagingSenderId = "672370746332";
const String kProjectId= "zensar-recipe-app";

const kBrightness = Brightness.light;
const kOrange = Colors.orange;
const kDark = Brightness.dark;

/// <eal DB URl's
const String kMealsCategories ='https://www.themealdb.com/api/json/v1/1/categories.php';
const String kMealsRandomItem = 'https://www.themealdb.com/api/json/v1/1/random.php';
const String kMealsSearchByQuery = "https://www.themealdb.com/api/json/v1/1/search.php?s=";
const String kMealsByCategoryQuery = "https://www.themealdb.com/api/json/v1/1/filter.php?c=";
const String kDummyLicense ='https://example.com/license';
const String kDummyPrivacyPolicy ='https://example.com/privacy-policy';


const kWelcomeScreenTitleStyle = TextStyle(
    fontSize: 24.0, color: Colors.lightBlue, fontWeight: FontWeight.bold);
const kWelcomeScreenSubTitleStyle = TextStyle(
    fontSize: 20.0, color: Colors.lightBlue, fontWeight: FontWeight.bold);

const kWelcomeScreenButStyle =
    TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);
const kLoginScreenTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);
const kLoginScreenButStyle =
TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);

const kFavouriteScreenTitleStyle = TextStyle(
    fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);

const kFavoriteScreenSubTitleStyle = TextStyle(
    fontSize: 25.0,
    color: Colors.blueGrey,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal
);

const kTextFieldDecoration = InputDecoration(
// Set a default hint text
  hintText: 'Enter a value',
// Set padding for the text field content
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// Define the border for the text field
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
// Define the enabled border for the text field
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
// Define the focused border for the text field
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
