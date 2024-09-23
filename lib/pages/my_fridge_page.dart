import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/pages/add_fridge_page.dart';
import 'package:smartfridge/widgets/search_bar.dart' as custom;

import 'edit_product_page.dart';

class MyFridgePage extends StatefulWidget {
  @override
  _MyFridgePageState createState() => _MyFridgePageState();
}

class _MyFridgePageState extends State<MyFridgePage> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("My Fridge"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            custom.SearchBar(
              controller: _searchController,
            ),
            Expanded(
              child: Consumer<FridgeRepository>(
                builder: (context, fridgeRepository, child) {
                  if (fridgeRepository.products.isEmpty ||
                      _filteredProducts.isEmpty &&
                          _searchController.text.isNotEmpty) {
                    return const Center(
                        child: Text("Nenhum produto encontrado"));
                  }
                  return ListView(
                    children: (_filteredProducts.isEmpty
                            ? fridgeRepository.products
                            : _filteredProducts)
                        .map<Widget>((product) {
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                            '${product.amount.value} ${product.amount.unit}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            fridgeRepository.removeProduct(product);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProductPage(product: product),
                            ),
                          );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFridgePage(onSave: _onAddProduct),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddProduct(BuildContext context, Product product) {
    Provider.of<FridgeRepository>(context, listen: false).addProduct(product);
  }
}