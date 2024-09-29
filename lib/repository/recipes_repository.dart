import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/utils/quantity.dart';

class RecipesRepository extends ChangeNotifier {
  final List<Recipe> _recipes = [];
  final String _apiUrl = 'http://10.0.0.104:8000/recipes';

  RecipesRepository() {
    fetchRecipes();
  }

  List<Recipe> get recipes => List.unmodifiable(_recipes);

  List<Recipe> getRecipesByName(String name) {
    return _recipes
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    final index = _recipes.indexWhere((element) => element.name == recipe.name);
    _recipes[index] = recipe;
    notifyListeners();
  }

  void clear() {
    _recipes.clear();
    notifyListeners();
  }

  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _recipes.clear();
        for (var recipeData in data) {
          final recipe = Recipe(
            recipeData['name'],
            recipeData['urlImage'],
            (recipeData['ingredients'] as List<dynamic>).map((ingredientData) {
              return Product(
                ingredientData['name'],
                Quantity.fromJson(ingredientData),
              );
            }).toList(),
            List<String>.from(recipeData['stepByStep']),
            Duration(
              hours: int.parse(recipeData['durationTime'].split(':')[0]),
              minutes: int.parse(recipeData['durationTime'].split(':')[1]),
              seconds: int.parse(recipeData['durationTime'].split(':')[2]),
            ),
          );
          _recipes.add(recipe);
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Error loading recipes: $e');
    }
  }
}