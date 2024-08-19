import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            child: Column(
          children: <Widget>[
            SearchBar(leading: Icon(Icons.search)),
            Container(
                height: 600,
                child: ListView(
                  children: widget.products.map((Product p) {
                      return Card(
                        child: Text(p.name, style: TextStyle(fontSize: 20),),
                        margin: EdgeInsets.all(8),
                      );
                  }).toList(),
                ))
          ],
        )));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Center(child: Text("My fridge")),
    );
  }
}
