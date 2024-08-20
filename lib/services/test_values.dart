import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/models/recipe.dart';

final List<Product> productsList = [
Product("Pão", 10, "Unidade(s)"),
Product("Carne", 2, "Kg"),
Product("Café", 200, "ml"),
Product("Arroz", 3, 'Kg'),
Product("Leite", 4, "L"),
Product("Maçã", 6, "Unidade(s)"),
Product("Queijo", 250, "g"),
Product("Ovos", 12, "Unidade(s)"),
Product("Iogurte", 500, "ml"),
Product("Tomate", 5, "Unidade(s)"),
Product("Açúcar", 1, "Kg"),
Product("Feijão", 500, "g"),
];

final List<Product> productsList2 = [
Product("Ovos", 30, "Unidade(s)"),
Product("Macarrão", 2, "Kg"),
Product("Café", 1, "L"),
Product("Arroz", 5, "Kg"),
Product("Feijão", 3, "Kg"),
Product("Leite", 4, "L"),
Product("Açúcar", 2, "Kg"),
Product("Banana", 12, "Unidade(s)"),
Product("Tomate", 8, "Unidade(s)"),
Product("Queijo", 500, "g"),
Product("Maçã", 10, "Unidade(s)"),
];

//dart project

final List<Recipe> recipesList = [
  Recipe("Lasanha", "assets/images/lasanha.jpg",
      [productsList[0], productsList2[0]],
  ),
  Recipe("Macarronada", "assets/images/macarronada.jpg",
      [productsList[1], productsList2[1], productsList[0]]
  ),
  Recipe("Bife Acebolado", "assets/images/bife acebolado.jpg",
      [productsList[2], productsList2[2], productsList[3]],
  ),
  Recipe("Pão de queijo", "assets/images/pao de queijo.jpg",
    [productsList[5], productsList2[4], productsList[1]],
  ),

];