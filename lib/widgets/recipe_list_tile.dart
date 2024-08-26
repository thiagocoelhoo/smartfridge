import 'package:flutter/material.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/pages/recipe_details.dart';
import 'package:smartfridge/repository/fridge_repository.dart';

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;
  final FridgeRepository fridgeRepository;

  const RecipeListTile({
    Key? key,
    required this.recipe,
    required this.fridgeRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailsPage(recipe)),
        );
      },
      title: Text(recipe.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "${fridgeRepository.hasInTheFridge(recipe.ingredients)}/${recipe.ingredients.length} ingredientes | ${recipe.duration.abreviation()}",
          overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.chevron_right),
      leading: Image.asset(recipe.urlImage, width: 120, fit: BoxFit.cover),
    );
  }
}
