import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/shopping_repository.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/widgets/add_button.dart';
import 'package:smartfridge/widgets/product_item.dart';
import 'package:smartfridge/widgets/show_product_modal.dart';

import 'package:smartfridge/widgets/delete_confirmation_dialog.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  final List<Product> _selectedProducts = [];
  final Map<Product, ValueNotifier<bool>> _isSelectedNotifiers = {};

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

  void _updateSelectedProducts(Product product, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedProducts.add(product);
      } else {
        _selectedProducts.remove(product);
      }
    });
  }

  void _buySelectedProducts() {
    _showMovedItemsAlert(_selectedProducts);
  }

  void _showMovedItemsAlert(List<Product> movedProducts) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(movedProducts.length > 1
                ? "Itens Comprados!"
                : "Item Comprado!"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: movedProducts
                .map((product) => Text("${product.amount} de ${product.name}"))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final fridgeRepository =
                    Provider.of<FridgeRepository>(context, listen: false);
                final shoppingRepository =
                    Provider.of<ShoppingRepository>(context, listen: false);

                for (var product in movedProducts) {
                  fridgeRepository.addProduct(product);
                  shoppingRepository.removeProduct(product);
                }

                setState(() {
                  _selectedProducts.clear();
                });

                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
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
                  if (shoppingRepository.products.isEmpty ||
                      _filteredProducts.isEmpty &&
                          _searchController.text.isNotEmpty) {
                    return const Center(
                        child: Text("Nenhum produto encontrado"));
                  }
                  return ListView(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    children: (_filteredProducts.isEmpty
                            ? shoppingRepository.products
                            : _filteredProducts)
                        .map((product) {
                      if (!_isSelectedNotifiers.containsKey(product)) {
                        _isSelectedNotifiers[product] =
                            ValueNotifier<bool>(false);
                      }
                      return ProductItem(
                        product: product,
                        isSelectedNotifier: _isSelectedNotifiers[product]!,
                        onProductTap: onProductTap,
                        onLeadingAction: (context, product) {},
                        onTrailingAction: onProductAction,
                        onChangeCheckbox: (isSelected) {
                          _updateSelectedProducts(product, isSelected);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: AddButton(onPressed: () {}),
          ),
          if (_selectedProducts.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: _buySelectedProducts,
                backgroundColor: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.green),
                    Text("Comprar", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

void onProductTap(BuildContext context, Product product) {
  showProductModal(context, product, (Product updatedProduct) {
    Provider.of<ShoppingRepository>(context, listen: false)
        .updateProduct(updatedProduct);
  }, (Product deletedProduct) {
    Provider.of<ShoppingRepository>(context, listen: false)
        .removeProduct(deletedProduct);
  });
}

void onProductAction(BuildContext context, Product product) {
  DeleteConfirmationDialog(context, () {
    Provider.of<ShoppingRepository>(context, listen: false)
        .removeProduct(product);
  });
}