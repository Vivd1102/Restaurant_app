import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zensar_recipe_app/components/navbar.dart';
import 'package:zensar_recipe_app/screens/category_details.dart';
import 'package:zensar_recipe_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zensar_recipe_app/routes/routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '/category_screen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<dynamic>? _categorydata;
  dynamic _isLoading;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            kCategoryTitle,
            style: kFavouriteScreenTitleStyle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: _isLoading
            ? Center(
                child: SizedBox(
                height: 200,
                width: 200,
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
                crossAxisCount: 2,
                shrinkWrap: true,
                children: _categorydata!.map<Widget>((mealsCat) {
                  //meals list map to loop over the list
                  return GestureDetector(
                    child: Card(
                        elevation: 5, //shadow elevation for card
                        margin: EdgeInsets.all(2),
                        child: Container(
                          color: Colors.grey.shade50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //main axix alignemnt to center
                            children: <Widget>[
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(mealsCat['strCategory'],
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic)),
                                    Image.network(mealsCat['strCategoryThumb'],
                                        width: 150, height: 150),
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
                    onTap: () => onCategorySelect(mealsCat['strCategory']),
                  );
                }).toList(),
              ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 0,
          onItemTapped: (index) {
            if (index == 1) {
              Navigator.pushReplacementNamed(context, Routes.search);
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, Routes.favorites);
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, Routes.settngs);
            }
          },
        ));
  }

  Future<List<dynamic>> _getCategories() async {
    List<dynamic> cats = [];
    _isLoading = true;
    final response = await http.get(Uri.parse(kMealsCategories));
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _categorydata = json.decode(response.body)['categories'];
      });
    } else {
      _isLoading = false;
      throw Exception('Failed to search recipes');
    }
    return cats;
  }

  onCategorySelect(mealsCategory) {
    Navigator.pushNamed(context, Routes.category_details,
        arguments: mealsCategory);
  }
}
