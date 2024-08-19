import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPage();
}

class _RecipesPage extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text("Recipes"),
      ),
      body: _body(context),
    );
  }


  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
          children:[
            Card(
              color: Theme.of(context).colorScheme.surfaceBright,
                margin: EdgeInsets.all(8),
                child: Text("Hi")
            ),
          ]
      ),
    );
  }
}