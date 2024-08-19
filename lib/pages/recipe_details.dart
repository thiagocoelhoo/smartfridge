import 'package:flutter/material.dart';
import 'package:smartfridge/widgets/carousel.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPage();
}

class _RecipeDetailsPage extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: Text("Recipes"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView();
  }
}
