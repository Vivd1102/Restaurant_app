import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zensar_recipe_app/components/navbar.dart';
import 'package:zensar_recipe_app/screens/recipe_screen.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryDetailsScreen extends StatefulWidget {
  static const String id = '/category_details';
  final dynamic mealsCategory;

  const CategoryDetailsScreen({Key? key, required this.mealsCategory})
      : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<dynamic>? _categorydata;
  dynamic _isLoading;

  @override
  void initState() {
    super.initState();
    _getCategoryDetails(widget.mealsCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kCategoryDetailsTitle,
          style: kFavouriteScreenTitleStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: _isLoading
          ? Center(
              child: SizedBox(
              height: 350,
              width: 350,
              child: SpinKitCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                  );
                },
              ),
            ))
          : GridView.count(
              crossAxisCount: 1,
              shrinkWrap: true,
              children: _categorydata!.map<Widget>((meals) {
                //meals list map to loop over the list
                return GestureDetector(
                  child: Card(
                      elevation: 5, //shadow elevation for card
                      margin: EdgeInsets.all(20),
                      child: Container(
                        color: Colors.grey.shade50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //main axix alignemnt to center
                          children: <Widget>[
                            SizedBox(
                              width: 350,
                              height: 350,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(meals['strMeal'],
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  Image.network(meals['strMealThumb'],
                                      width: 250, height: 300),
                                  /*  Text(
                                '₹ ${product.strCategoryThumb}',
                                style: const TextStyle(fontSize: 18.0),
                              ),*/
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  //onTap: () => final recipe = onCategorySelect(meals),
                  onTap: () async {
                    final recipe = await onCategorySelect(meals);
                    Navigator.pushNamed(context, Routes.recipe,
                        arguments: recipe);
                  },
                );
              }).toList(),
            ),
    );
  }

  Future<List<dynamic>> _getCategoryDetails(mealsCategory) async {
    List<dynamic> cats = [];
    _isLoading = true;
    final url = kMealsByCategoryQuery + '${mealsCategory}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _categorydata = json.decode(response.body)['meals'];
      });
    } else {
      _isLoading = false;
      throw Exception('Failed to search recipes');
    }
    return cats;
  }

  Future<dynamic> onCategorySelect(meals) async {
    final url = kMealsSearchByQuery + '${meals['strMeal']}';
    /*final url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=" +
        '${meals['idMeal']}';*/
    final response = await http.get(Uri.parse(url));
    print("response ===== $response");
    final data = jsonDecode(response.body);
    print("response ===== $data['meals]");
    return data['meals'][0];
  }
}
