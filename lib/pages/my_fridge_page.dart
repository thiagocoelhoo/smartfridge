import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartfridge/pages/add_items_fridge_page.dart';

class Product {
  String name;
  int amount;

  Product(this.name, this.amount);
}

class MyFridgePage extends StatefulWidget {
  List<Product> products = [
    Product("Pão", 10),
    Product("Carne", 2),
    Product("Café", 1),
    Product("Arroz", 3),
    Product("Pão", 10),
    Product("Carne", 2),
    Product("Café", 1),
    Product("Arroz", 3),
    Product("Pão", 10),
    Product("Carne", 2),
    Product("Café", 1),
    Product("Arroz", 3),
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
                      margin: EdgeInsets.all(8),
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
                            Text(p.amount.toString() + ' Kg'),
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
