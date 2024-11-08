import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/recipes_repository.dart';
import 'package:smartfridge/widgets/carousel.dart';
import 'package:smartfridge/widgets/recipe_list_tile.dart';
import 'package:smartfridge/widgets/search_bar.dart' as custom;

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPage();
}

class _RecipesPage extends State<RecipesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipes);
    _fetchRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = Provider.of<RecipesRepository>(context, listen: false)
          .recipes
          .where((recipe) => recipe.name.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _fetchRecipes() async {
    await Provider.of<RecipesRepository>(context, listen: false).fetchRecipes();
    _filterRecipes();
  }

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
      child: Consumer<RecipesRepository>(
        builder: (context, recipeRepository, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, bottom: 12, right: 12, top: 4),
                child: custom.SearchBar(
                  controller: _searchController,
                ),
              ),
              Column(
                children: [
                  if (_searchController.text.isEmpty &&
                      recipeRepository.recipes.isNotEmpty) ...[
                    const Text("Destaques", style: TextStyle(fontSize: 22)),
                    const SizedBox(height: 10),
                    Carousel(
                      images: [
                        ...recipeRepository.recipes.map((Recipe r) {
                          return Image.asset(r.urlImage);
                        }),
                      ],
                      height: 400,
                    ),
                  ],
                  const SizedBox(height: 22),
                  ...(recipeRepository.recipes.isEmpty ||
                          _filteredRecipes.isEmpty &&
                              _searchController.text.isNotEmpty
                      ? [
                          const Center(
                            child: Text("Nenhuma receita Encontrada"),
                          )
                        ]
                      : (_filteredRecipes.isEmpty
                          ? recipeRepository.recipes.map((recipe) {
                              return _recipeCard(recipe);
                            }).toList()
                          : _filteredRecipes.map((recipe) {
                              return _recipeCard(recipe);
                            }).toList())),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recipeCard(Recipe recipe) {
    return GestureDetector(
      child: Card(
        child: Consumer<FridgeRepository>(
          builder: (context, fridgeRepository, child) {
            return RecipeListTile(
              recipe: recipe,
              fridgeRepository: fridgeRepository,
            );
          },
        ),
      ),
    );
  }
}