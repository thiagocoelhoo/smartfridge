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
    return const Center(
      child: Text(
        "Recipe not found",
        style: TextStyle(fontSize: 20, color: Colors.black12),
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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  border: Border.all(
                      color: const Color.fromRGBO(73, 69, 79, 1), width: 1.5),
                  borderRadius: BorderRadius.circular(22),
                ),
                width: double.infinity,
                height: 400,
                child: Column(
                  children: widget.recipe!.ingredients.map((product) {
                    return ListTile(title: Text("${product.amount} de ${product.name}"));
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Modo de preparo", style: TextStyle(fontSize: 20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    border: Border.all(
                        color: const Color.fromRGBO(73, 69, 79, 1), width: 1.5),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  width: double.infinity,
                  height: 400,
                  child: Column(
                    children: widget.recipe!.stepByStep.asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      return ListTile(title: Text("${index + 1}. $step"));
                    }).toList(),
                  )),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              // a purple cor when in dark mode
                color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                height: 60,
                minWidth: double.infinity,
                onPressed: () {},
                child: Text(
                  "Iniciar receita",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
        ));
  }
}