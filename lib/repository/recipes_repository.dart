import 'package:flutter/material.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/controllers/recipes_controller.dart';

class RecipesRepository extends ChangeNotifier {
  final RecipesController _controller = RecipesController();

  List<Recipe> get recipes => _controller.recipes;

  List<Recipe> getRecipesByName(String name) {
    return _controller.getRecipesByName(name);
  }

  void addRecipe(Recipe recipe) {
    _controller.addRecipe(recipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _controller.removeRecipe(recipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    _controller.updateRecipe(recipe);
    notifyListeners();
  }

  void clear() {
    _controller.clear();
    notifyListeners();
  }
}