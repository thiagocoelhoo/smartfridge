import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/shopping_repository.dart';
import 'package:smartfridge/utils/quantity.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/widgets/product_list.dart';
import 'package:smartfridge/widgets/show_product_modal.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

final List<String> unitOptions = Quantity.getUnits();

class _ShoppingListPage extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Shopping list"),
      ),
      body: Consumer<ShoppingRepository>(
        builder: (context, shoppingRepository, child) {
          return ProductList(
            products: shoppingRepository.products,
            showTrailing: true,
            onProductTap: onProductTap,
            onProductAction: _showConfirmationDialog,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryFixedVariant,
        foregroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}

void onProductTap(BuildContext context, Product product) {
  showProductModal(context, product, (Product updatedProduct) {
    Provider.of<ShoppingRepository>(context, listen: false)
        .updateProduct(updatedProduct);
  });
}

void _showConfirmationDialog(BuildContext context, Product product) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer2<FridgeRepository, ShoppingRepository>(
          builder: (context, fridgeRepository, shoppingRepository, child) {
            return AlertDialog(
              title: const Center(
                child: Text("Item Comprado!"),
              ),
              content: Text(
                  "${product.amount} de ${product.name} ${product.amount.value > 1 ? 'foram' : 'foi'} movidos para o estoque."),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () {
                    fridgeRepository.addProduct(product);
                    shoppingRepository.removeProduct(product);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          });
    },
  );
}