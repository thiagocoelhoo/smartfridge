import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/pages/add_items_fridge_page.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/widgets/add_button.dart';
import 'package:smartfridge/widgets/product_card.dart';

import '../models/product.dart';

class MyFridgePage extends StatefulWidget {
  const MyFridgePage({super.key});

  @override
  State<MyFridgePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyFridgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SearchBar(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.filter_alt),
                ),
                trailing: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Consumer<FridgeRepository>(
                  builder: (context, fridgeRepository, child) {
                    return ListView(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      children: fridgeRepository.products.map<Widget>((Product p) {
                        return ProductCard(product: p);
                      }).toList(),
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
}