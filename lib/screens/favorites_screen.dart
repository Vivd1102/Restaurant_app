import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'dart:convert';
import 'recipe_screen.dart';
import 'package:zensar_recipe_app/components/navbar.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FavoritesScreen extends StatefulWidget {
  static const String id = '/favorites_screen';

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<String> _favoriteRecipes;
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    });
  }

  Future<void> _removeFavoriteRecipe(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final recipeName = _favoriteRecipes[index];
    final confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Recipe'),
          content: Text('Are you sure you want to remove "$recipeName"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      setState(() {
        _favoriteRecipes.removeAt(index);
        prefs.setStringList('favoriteRecipes', _favoriteRecipes);
      });
    }
  }

  Future<dynamic> _getRecipe(String recipeName) async {
    final url = kMealsSearchByQuery + '${recipeName.replaceAll(' ', '%20')}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    return data['meals'][0];
  }

  Future<void> _sendRecipeByEmail(String recipeName) async {
    final emailBody = 'Here is a recipe for $recipeName';
    final subject = 'Recipe: $recipeName';
    final isHTML = false;
    final recipient = _recipientController.text;
    final Email email = Email(
      body: emailBody,
      subject: subject,
      recipients: [recipient],
      isHTML: isHTML,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(kFavouriteRecipeText, style: kFavouriteScreenTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Card(
                elevation: 5,
                shadowColor: Colors.amber,
                color: Colors.white,
                child: Text(
                  kFavouriteRecipeSubText,
                  style: kFavoriteScreenSubTitleStyle,
                ),
              ),
            ),
            Expanded(
              child: _favoriteRecipes.isEmpty
                  ? Center(
                      child: Text(kNoFavouriteRecipeText),
                    )
                  : ListView.builder(
                      itemCount: _favoriteRecipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final recipeName = _favoriteRecipes[index];
                        return Card(
                          elevation: 15,
                          shadowColor: Colors.amber,
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              recipeName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_forever_rounded,
                                  color: Colors.grey),
                              onPressed: () {
                                _removeFavoriteRecipe(index);
                              },
                            ),
                            onTap: () async {
                              final recipe = await _getRecipe(recipeName);
                              Navigator.pushNamed(context, Routes.recipe,
                                  arguments: recipe);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.category);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.search);
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, Routes.settngs);
          }
        },
      ),
    );
  }
}
