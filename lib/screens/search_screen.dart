import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'recipe_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'package:zensar_recipe_app/components//navbar.dart';

class SearchScreen extends StatefulWidget {
  static const String id = '/search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic>? _recipes;

// Method to search recipes based on a query
  Future<void> _searchRecipes(String query) async {
    final response = await http.get(Uri.parse(
        kMealsSearchByQuery+'$query'));

    if (response.statusCode == 200) {
      setState(() {
        _recipes = json.decode(response.body)['meals'];
      });
    } else {
      throw Exception('Failed to search recipes');
    }
  }

// Method to navigate to a random recipe
  Future<void> _navigateToRandomRecipe() async {
    final response = await http
        .get(Uri.parse(kMealsRandomItem));

    if (response.statusCode == 200) {
      final randomRecipe = json.decode(response.body)['meals'][0];
      Navigator.pushNamed(
        context,
        Routes.recipe,
        arguments: randomRecipe,
      );
    } else {
      throw Exception('Failed to fetch a random recipe');
    }
  }

  int _selectedIndex = 0;


// Override build method, returns a Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text(kSearchScreenText,style: kFavouriteScreenTitleStyle), automaticallyImplyLeading: false,),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  kSearchSubTitle,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  onSubmitted: _searchRecipes,
                  decoration: InputDecoration(
                    hintStyle:TextStyle(fontSize:16,color: Colors.grey.shade300,fontWeight: FontWeight.bold) ,
                    hintText: kSearchHintTxt,
                    prefixIcon: Icon(FontAwesomeIcons.searchengin),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
// Recipe list
          Expanded(
            child: _recipes == null
                ? Center(child: Text(kSearchForaMealText))
                : _recipes!.isEmpty
                    ? Center(child: Text(kSearchNoMeal))
                    : ListView.builder(
                        itemCount: _recipes!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildRecipeCard(_recipes![index]);
                        },
                      ),
          ),
        ],
      ),
      // Floating action button for random recipe
      floatingActionButton: ElevatedButton(
        onPressed: _navigateToRandomRecipe,
        style: ElevatedButton.styleFrom(
          elevation: 50,
          primary: Colors.transparent,
          onPrimary: Colors.amber,
          side: BorderSide(color: Colors.lightBlueAccent, width: 5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Text(
            kRandomMealText,

            style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold,color:
            Colors.amber),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.category);
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.favorites);
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, Routes.settngs);
          }
        },
      ),
    );
  }

// Widget function to build recipe card
  Widget _buildRecipeCard(dynamic recipe) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context,Routes.recipe,arguments: recipe);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
// Display recipe image
            Image.network(
              recipe['strMealThumb'] ?? '',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
// Display recipe name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe['strMeal'] ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
