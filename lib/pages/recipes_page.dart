import 'package:flutter/material.dart';
import 'package:smartfridge/pages/recipe_details.dart';
import 'package:smartfridge/widgets/carousel.dart';

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
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Recipes"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Receitas Populares", style: TextStyle(fontSize: 20)),
          Carousel(
            images: [
              Image.asset("assets/images/bife acebolado.jpg"),
              Image.asset("assets/images/pao de queijo.jpg"),
              Image.asset("assets/images/lasanha.jpg"),
              Image.asset("assets/images/macarronada.jpg"),
            ],
            height: 400,
          ),
          const SizedBox(height: 20),
          const Text("Recomendados", style: TextStyle(fontSize: 20)),
          _recipeCard("assets/images/bife acebolado.jpg", "Bife acebolado",
              "3/5 ingredientes"),
          _recipeCard("assets/images/lasanha.jpg", "Lasanha de forno",
              "Todos os ingredientes"),
          _recipeCard("assets/images/macarronada.jpg",
              "Macarronada com ervilhas", "2/4 ingredientes"),
          _recipeCard("assets/images/pao de queijo.jpg",
              "Pão de queijo mineiro", "3/4 ingredientes"),
        ],
      ),
    );
  }

  Widget _recipeCard(String imagePath, String title, String subtitle) {
    return GestureDetector(
      child: Card(
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipeDetailsPage()),
                );
              },
            ),
            leading: Image.asset(imagePath, width: 120, fit: BoxFit.cover)),
      ),
    );
  }
}
