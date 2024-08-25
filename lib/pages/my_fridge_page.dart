import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/pages/add_items_fridge_page.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/widgets/add_button.dart';
import 'package:smartfridge/widgets/product_list.dart';
import 'package:smartfridge/widgets/show_product_modal.dart';
import 'package:smartfridge/widgets/delete_confirmation_dialog.dart';

import 'package:smartfridge/models/product.dart';

class MyFridgePage extends StatefulWidget {
  const MyFridgePage({super.key});

  @override
  State<MyFridgePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyFridgePage> {
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
      _filteredProducts = Provider.of<FridgeRepository>(context, listen: false)
          .products
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SearchBar(
                controller: _searchController,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.filter_alt),
                ),
                trailing: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search),
                  )
                ],
                onChanged: (value) {
                  _filterProducts();
                },
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Consumer<FridgeRepository>(
                  builder: (context, fridgeRepository, child) {
                    if (fridgeRepository.products.isEmpty ||
                        _filteredProducts.isEmpty &&
                            _searchController.text.isNotEmpty) {
                      return const Center(
                          child: Text("Nenhum produto encontrado"));
                    }
                    return ProductList(
                      products: _filteredProducts.isEmpty
                          ? fridgeRepository.products
                          : _filteredProducts,
                      onProductTap: onProductTap,
                      onProductAction: onProductAction,
                      showTrailing: true,
                      customIcon: const Icon(Icons.delete_outline_rounded),
                      iconColor: Colors.redAccent,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemsFridgePage()),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: const Center(child: Text("My fridge")),
    );
  }

  void onProductTap(BuildContext context, Product product) {
    showProductModal(context, product, (Product updatedProduct) {
      Provider.of<FridgeRepository>(context, listen: false)
          .updateProduct(updatedProduct);
    }, (Product deletedProduct) {
      Provider.of<FridgeRepository>(context, listen: false)
          .removeProduct(product);
    });
  }

  void onProductAction(BuildContext context, Product product) {
    DeleteConfirmationDialog(context, () {
      Provider.of<FridgeRepository>(context, listen: false)
          .removeProduct(product);
    });
  }
}
