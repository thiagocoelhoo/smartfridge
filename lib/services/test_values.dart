import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/models/recipe.dart';

import 'package:smartfridge/utils/quantity.dart';
import 'package:smartfridge/utils/duration_time.dart';

final List<Product> productsList = [
  Product("Pão", Quantity(10, QuantityUnit.UNIT)),
  Product("Carne", Quantity(1, QuantityUnit.KILOGRAM)),
  Product("Café", Quantity(200, QuantityUnit.MILLILITER)),
  Product("Arroz", Quantity(2, QuantityUnit.KILOGRAM)),
  // Product("Leite", 4, "L"),
  // Product("Maçã", 6, "Unidade(s)"),
  // Product("Queijo", 250, "g"),
  // Product("Ovos", 12, "Unidade(s)"),
  // Product("Iogurte", 500, "ml"),
  // Product("Tomate", 5, "Unidade(s)"),
  // Product("Açúcar", 1, "Kg"),
  // Product("Feijão", 500, "g"),
];

final List<Product> productsList2 = [
  Product("Ovos", Quantity(12, QuantityUnit.UNIT)),
  Product("Macarrão", Quantity(500, QuantityUnit.GRAM)),
  Product("Café", Quantity(200, QuantityUnit.MILLILITER)),
  Product("Arroz", Quantity(2, QuantityUnit.KILOGRAM)),
  // Product("Feijão", 3, "Kg"),
  // Product("Leite", 4, "L"),
  // Product("Açúcar", 2, "Kg"),
  // Product("Banana", 12, "Unidade(s)"),
  // Product("Tomate", 8, "Unidade(s)"),
  // Product("Queijo", 500, "g"),
  // Product("Maçã", 10, "Unidade(s)"),
];

//dart project

final List<Recipe> recipesList = [
  Recipe(
    "Lasanha",
    "assets/images/lasanha.jpg",
    [productsList[0], productsList2[0]],
    [
      "Cozinhe a massa segundo as instruções do fabricante, despeje em um refratário com água gelada para não grudar e reserve",
      "Refogue o alho, a cebola, a carne moída, o molho de tomate, deixe cozinhar por 3 minutos e reserve",
      "Em um refratário, coloque uma camada de massa, uma de molho, uma de presunto, uma de queijo, e repita as camadas até acabar os ingredientes",
      "Finalize com queijo ralado e leve ao forno por 20 minutos"
    ],
      DurationTime(1, TimeUnit.HOURS)
    ),
  Recipe(
  "Macarronada",
  "assets/images/macarronada.jpg",
  [productsList[1], productsList2[1], productsList[0]],
    [
      "Em uma panela, leve a carne moída temperada ao fogo e adicione o milho verde e a ervilha.",
      "Misture tudo e deixe cozinhar por 30 minutos.",
      "Desligue o fogo e acrescente o creme de leite e o molho de tomate.",
      "Misture bem e reserve.",
    ],
    DurationTime(30, TimeUnit.MINUTES)
    ),
  // Recipe("Bife Acebolado", "assets/images/bife acebolado.jpg",
  //     [productsList[2], productsList2[2], productsList[3]],
  // ),
  // Recipe("Pão de queijo", "assets/images/pao de queijo.jpg",
  //   [productsList[5], productsList2[4], productsList[1]],
  // ),
];
