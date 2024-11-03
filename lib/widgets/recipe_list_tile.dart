import 'package:flutter/material.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/pages/recipe_details.dart';
import 'package:smartfridge/repository/fridge_repository.dart';

class RecipeListTile extends StatefulWidget {
  final Recipe recipe;
  final FridgeRepository fridgeRepository;

  const RecipeListTile({
    super.key,
    required this.recipe,
    required this.fridgeRepository,
  });

  @override
  _RecipeListTileState createState() => _RecipeListTileState();
}

class _RecipeListTileState extends State<RecipeListTile> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetailsPage(widget.recipe)),
        );
      },
      title: Text(widget.recipe.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "${widget.fridgeRepository.hasInTheFridge(widget.recipe.ingredients)}/${widget.recipe.ingredients.length} ingredientes",
          overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: _toggleFavorite,
      ),
      leading:
          Image.asset(widget.recipe.urlImage, width: 120, fit: BoxFit.cover),
    );
  }
}