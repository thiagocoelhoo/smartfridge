import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/widgets/carousel.dart';
import 'package:smartfridge/widgets/product_line.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/repository/shopping_repository.dart';
import 'package:smartfridge/models/product.dart';

import '../widgets/custom_snackbar.dart';

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
                child: Column(
                  children: widget.recipe!.ingredients.map((product) {
                    return ProductLine(
                        product: product,
                        onTrailingAction: (context, product) {
                          addProductToCart(context, product);
                        });
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
                  child: Column(
                    children:
                        widget.recipe!.stepByStep.asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      return ListTile(title: Text("${index + 1}. $step"));
                    }).toList(),
                  )),
            ),
            const SizedBox(height: 20),
            // MaterialButton(
            //     color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20)),
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            //     height: 60,
            //     minWidth: double.infinity,
            //     onPressed: () {},
            //     child: Text(
            //       "Iniciar receita",
            //       style: TextStyle(
            //         color: Theme.of(context).colorScheme.inverseSurface,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ))
          ],
        ));
  }
}

void addProductToCart(BuildContext context, Product product) {
  final shoppingRepository =
      Provider.of<ShoppingRepository>(context, listen: false);
  shoppingRepository.addProduct(product);
  customSnackBar(
    context,
    "${product.name} adicionado ao carrinho",
    backgroundColor: Colors.green,
    textColor: Colors.white,
    duration: const Duration(seconds: 2),
  );
}