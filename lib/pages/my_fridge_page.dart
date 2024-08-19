import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartfridge/pages/add_items_fridge_page.dart';

import '../models/product.dart';

class MyFridgePage extends StatefulWidget {
  List<Product> products = [
    Product("Pão", 10, "Unidade(s)"),
    Product("Carne", 2, "Kg"),
    Product("Café", 200, "ml"),
    Product("Arroz", 3, 'Kg'),
    Product("Leite", 4, "L"),
    Product("Maçã", 6, "Unidade(s)"),
    Product("Queijo", 250, "g"),
    Product("Ovos", 12, "Unidade(s)"),
    Product("Iogurte", 500, "ml"),
    Product("Tomate", 5, "Unidade(s)"),
    Product("Açúcar", 1, "Kg"),
    Product("Feijão", 500, "g"),
  ];

  MyFridgePage({super.key});

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
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SearchBar(
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
                SizedBox(height: 16.0),
                Expanded(
                    child: ListView(
                  children: widget.products.map((Product p) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 0,
                      margin: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.fastfood),
                                SizedBox(width: 16),
                                Text(
                                  p.name,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Text(p.amount.toString() + " " + p.unit!),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ))
              ],
            )),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddItemsFridgePage()),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Add"),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: Center(child: Text("My fridge")),
    );
  }
}
