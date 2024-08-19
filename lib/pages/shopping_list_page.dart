import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage();

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text("Shopping list"),
      ),
    );
  }
}