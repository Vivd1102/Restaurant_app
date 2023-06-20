import 'package:flutter/material.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zensar_recipe_app/components//navbar.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';

class RecipeScreen extends StatefulWidget {
  static const String id = '/recipe_screen';

  final dynamic recipe;

  const RecipeScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool isFavorite = false;
  List<String> _favoriteRecipes = [];
  int _selectedIndex = 0;

// Load the favorite status of the current recipe
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

// Load favorite status from shared preferences
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite =
          prefs.getBool(widget.recipe['idMeal']?.toString() ?? '') ?? false;
      _favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    });
  }

// Toggle the favorite status of the current recipe
  void _toggleFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String recipeName = widget.recipe['strMeal'] ?? '';
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
// Add recipe to favorites
        _favoriteRecipes.add(recipeName);
      } else {
// Remove recipe from favorites
        _favoriteRecipes.remove(recipeName);
      }
      prefs.setStringList('favoriteRecipes', _favoriteRecipes);
    });
  }

// Navigate to different screens based on the item tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, Routes.category);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, Routes.search);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, Routes.favorites);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, Routes.settngs);
    }
  }

// Build the recipe screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe['strMeal'] ?? ''),
        actions: [
// Button to add/remove recipe from favorites
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavoriteStatus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
// Display recipe image
            Image.network(
              widget.recipe['strMealThumb'] ??
                  'https://via.placeholder.com/150',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildIngredientsList(widget.recipe),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.recipe['strInstructions'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),*/
    );
  }

  List<Widget> _buildIngredientsList(dynamic recipe) {
    final List<Widget> list = [];

    for (int i = 1; i <= 20; i++) {
      if (recipe['strIngredient$i'] != null &&
          recipe['strIngredient$i'] != '') {
        list.add(Text(
          '- ${recipe['strMeasure$i']} ${recipe['strIngredient$i']}',
          style: TextStyle(fontSize: 16.0),
        ));
      }
    }

    return list;
  }
}
