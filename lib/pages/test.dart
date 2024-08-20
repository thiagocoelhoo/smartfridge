import 'package:flutter/material.dart';

import '../api/api_service.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String mealId;

  const RecipeDetailsScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Receita')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().fetchRecipeDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao buscar a receita'));
          } else {
            final recipe = snapshot.data!;
            return Column(
              children: [
                Image.network(recipe['strMealThumb']),
                Text(recipe['strMeal']),
                Text(recipe["strInstructions"])
                // Adicione outras informações da receita aqui
              ],
            );
          }
        },
      ),
    );
  }
}
