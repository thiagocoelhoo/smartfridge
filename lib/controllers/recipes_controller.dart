import 'package:smartfridge/models/recipe.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/utils/duration_time.dart';
import 'package:smartfridge/utils/quantity.dart';

class RecipesController {
  final List<Recipe> _recipes = [];

  RecipesController() {
    _loadInitialRecipes();
  }

  List<Recipe> get recipes => List.unmodifiable(_recipes);

  List<Recipe> getRecipesByName(String name) {
    return _recipes
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);
  }

  void updateRecipe(Recipe recipe) {
    final index = _recipes.indexWhere((element) => element.name == recipe.name);
    _recipes[index] = recipe;
  }

  void clear() {
    _recipes.clear();
  }

  void _loadInitialRecipes() {
    _recipes.addAll([
      Recipe(
          "Lasanha",
          "assets/images/lasanha.jpg",
          [
            Product("Massa de lasanha", Quantity(500, QuantityUnit.gram)),
            Product("Presunto", Quantity(500, QuantityUnit.gram)),
            Product("Queijo ralado", Quantity(500, QuantityUnit.gram)),
          ],
          [
            "Cozinhe a massa segundo as instruções do fabricante, despeje em um refratário com água gelada para não grudar e reserve",
            "Refogue o alho, a cebola, a carne moída, o molho de tomate, deixe cozinhar por 3 minutos e reserve",
            "Em um refratário, coloque uma camada de massa, uma de molho, uma de presunto, uma de queijo, e repita as camadas até acabar os ingredientes",
            "Finalize com queijo ralado e leve ao forno por 20 minutos"
          ],
          DurationTime(1, TimeUnit.hours)),
      Recipe(
          "Macarronada",
          "assets/images/macarronada.jpg",
          [
            Product("Macarrão", Quantity(500, QuantityUnit.gram)),
            Product("Carne", Quantity(1, QuantityUnit.kilogram)),
            Product("Tomate", Quantity(8, QuantityUnit.unit)),
            Product("Queijo", Quantity(500, QuantityUnit.gram)),
            Product("Milho", Quantity(500, QuantityUnit.gram)),
            Product("Ervilha", Quantity(500, QuantityUnit.gram)),
          ],
          [
            "Em uma panela, leve a carne moída temperada ao fogo e adicione o milho verde e a ervilha.",
            "Misture tudo e deixe cozinhar por 30 minutos.",
            "Desligue o fogo e acrescente o creme de leite e o molho de tomate.",
            "Misture bem e reserve.",
          ],
          DurationTime(30, TimeUnit.minutes)),
      Recipe(
          "Bolo de Maçã",
          "assets/images/bolo_de_maca.jpg",
          [
            Product("Maçã", Quantity(10, QuantityUnit.unit)),
            Product("Leite", Quantity(4, QuantityUnit.liter)),
            Product("Açúcar", Quantity(2, QuantityUnit.kilogram)),
          ],
          [
            "Bata no liquidificador os ovos, o óleo, o açúcar e as maçãs.",
            "Em uma tigela, misture a farinha de trigo e o fermento.",
            "Despeje a mistura do liquidificador na tigela e misture bem.",
            "Coloque em uma forma untada e leve ao forno por 40 minutos."
          ],
          DurationTime(40, TimeUnit.minutes)),
      Recipe(
          "Bife acebolado",
          "assets/images/bife acebolado.jpg",
          [
            Product("Bife", Quantity(1, QuantityUnit.kilogram)),
            Product("Cebola", Quantity(1, QuantityUnit.kilogram)),
            Product("Alho", Quantity(500, QuantityUnit.gram)),
            Product("Sal", Quantity(500, QuantityUnit.gram)),
            Product("Pimenta", Quantity(500, QuantityUnit.gram)),
          ],
          [
            "Tempere os bifes com sal, pimenta e alho.",
            "Em uma frigideira, frite os bifes até dourar.",
            "Adicione a cebola e deixe dourar.",
            "Sirva quente."
          ],
          DurationTime(30, TimeUnit.minutes)),
      Recipe(
          "Pão de queijo",
          "assets/images/pao de queijo.jpg",
          [
            Product("Polvilho", Quantity(500, QuantityUnit.gram)),
            Product("Queijo", Quantity(500, QuantityUnit.gram)),
            Product("Leite", Quantity(500, QuantityUnit.milliliter)),
            Product("Ovo", Quantity(10, QuantityUnit.unit)),
          ],
          [
            "Em uma panela, ferva o leite e o óleo.",
            "Em uma tigela, misture o polvilho e o queijo.",
            "Adicione o leite e o óleo fervidos e misture bem.",
            "Adicione os ovos e misture bem.",
            "Coloque em forminhas e leve ao forno por 30 minutos."
          ],
          DurationTime(30, TimeUnit.minutes))
    ]);
  }
}
