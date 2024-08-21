import 'package:flutter/material.dart';
import 'package:smartfridge/widgets/carousel.dart';
import '../models/recipe.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe? recipe;

  const RecipeDetailsPage(this.recipe, {super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPage();
}

class _RecipeDetailsPage extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Recipes"),
      ),
      body: widget.recipe == null ? _noRecipeFound() : _body(context),
    );
  }

  Widget _noRecipeFound() {
    return Center(
      child: Text(
        "Recipe not found",
        style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.recipe!.name, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 12),
            Carousel(
              images: [
                Image.asset(widget.recipe!.urlImage),
              ],
              height: 400,
            ),
            const SizedBox(height: 20),
            const Text("Ingredientes", style: TextStyle(fontSize: 20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  width: double.infinity,
                  height: 400,
                  child: ListView(
                    children:
                      widget.recipe!.ingredients.map((product) {
                        return ListTile(title: Text("${product.amount} de ${product.name}"));
                      }).toList(),
                  )),
            ),
            const SizedBox(height: 20),
            const Text("Modo de preparo", style: TextStyle(fontSize: 20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  width: double.infinity,
                  height: 400,
                  child: ListView(
                    children: widget.recipe!.stepByStep.asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      return ListTile(title: Text("${index + 1} - $step"));
                    }).toList(),
                  )),
            ),
            const SizedBox(height: 20),
            MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                height: 60,
                minWidth: double.infinity,
                onPressed: () {},
                child: Text(
                  "Iniciar receita",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ))
          ],
        ));
  }
}