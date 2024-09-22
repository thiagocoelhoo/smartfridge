import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/pages/add_fridge_page.dart';

import 'edit_product_page.dart';

class MyFridgePage extends StatefulWidget {
  @override
  _MyFridgePageState createState() => _MyFridgePageState();
}

class _MyFridgePageState extends State<MyFridgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fridge'),
      ),
      body: Consumer<FridgeRepository>(
        builder: (context, fridgeRepository, child) {
          return ListView(
            children: fridgeRepository.products.map<Widget>((product) {
              return ListTile(
                title: Text(product.name),
                subtitle:
                    Text('${product.amount.value} ${product.amount.unit}'),
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
                      builder: (context) => EditProductPage(product: product),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
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