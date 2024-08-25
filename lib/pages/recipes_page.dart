import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/pages/recipe_details.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/recipes_repository.dart';
import 'package:smartfridge/widgets/carousel.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPage();
}

class _RecipesPage extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Recipes"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Consumer<RecipesRepository>(
        builder: (context, recipeRepository, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 4),
                child: const SearchBar(
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.filter_alt),
                  ),
                  trailing: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const Text("Destaques", style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 10),
                  Carousel(
                    images: [
                      ...recipeRepository.recipes.map((Recipe r) {
                        return Image.asset(r.urlImage);
                      }),
                    ],
                    height: 400,
                  ),
                  const SizedBox(height: 22),
                  const Text("Recomendados", style: TextStyle(fontSize: 20)),
                  ...recipeRepository.recipes.map((Recipe r) {
                    return _recipeCard(r);
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recipeCard(Recipe recipe) {
    return GestureDetector(
      child: Card(
        child: Consumer<FridgeRepository>(
          builder: (context, fridgeRepository, child) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeDetailsPage(recipe)),
                );
              },
              title: Text(recipe.name),
              subtitle: Text("${fridgeRepository.hasInTheFridge(recipe.ingredients)}/${recipe.ingredients.length} ingredients // ${recipe.duration}"),
              trailing: const Icon(Icons.chevron_right),
              leading: Image.asset(recipe.urlImage, width: 120, fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}