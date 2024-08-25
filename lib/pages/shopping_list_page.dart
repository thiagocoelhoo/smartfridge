import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/shopping_repository.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/widgets/add_button.dart';
import 'package:smartfridge/widgets/product_list.dart';
import 'package:smartfridge/widgets/show_product_modal.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          Provider.of<ShoppingRepository>(context, listen: false)
              .products
              .where((product) => product.name.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Shopping list"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SearchBar(
              controller: _searchController,
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.filter_alt),
              ),
            ),
            Expanded(
              child: Consumer<ShoppingRepository>(
                builder: (context, shoppingRepository, child) {
                  if (_filteredProducts.isEmpty &&
                      _searchController.text.isNotEmpty) {
                    return const Center(
                        child: Text("Nenhum produto encontrado"));
                  }
                  return ProductList(
                    products: _filteredProducts.isEmpty
                        ? shoppingRepository.products
                        : _filteredProducts,
                    showTrailing: true,
                    onProductTap: onProductTap,
                    onProductAction: _showConfirmationDialog,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(onPressed: () {}),
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
