import 'package:flutter/material.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/pages/recipe_details.dart';
import 'package:smartfridge/services/test_values.dart';
import 'package:smartfridge/widgets/carousel.dart';

class RecipesPage extends StatefulWidget {
  List<Recipe> recipes = recipesList;

  RecipesPage({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Receitas Populares", style: TextStyle(fontSize: 20)),
          Carousel(
            images: [
              ...widget.recipes.map((Recipe r) {
                return Image.asset(r.urlImage);
              }).toList(),
            ],
            height: 400,
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text("Recomendados", style: TextStyle(fontSize: 20)),
              ...widget.recipes.map((Recipe r) {
                return _recipeCard(r.urlImage, r.name, "${r.ingredients.length} ingredients");
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recipeCard(String imagePath, String title, String subtitle) {
    return GestureDetector(
      child: Card(
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecipeDetailsPage()),
                );
              },
            ),
            leading: Image.asset(imagePath, width: 120, fit: BoxFit.cover)),
      ),
    );
  }
}
