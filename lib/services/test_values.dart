import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/models/recipe.dart';

import 'package:smartfridge/utils/quantity.dart';
import 'package:smartfridge/utils/duration_time.dart';

final List<Product> productsList = [
  Product("Pão", Quantity(10, QuantityUnit.UNIT)),
  Product("Carne", Quantity(1, QuantityUnit.KILOGRAM)),
  Product("Café", Quantity(200, QuantityUnit.MILLILITER)),
  Product("Arroz", Quantity(2, QuantityUnit.KILOGRAM)),
  Product("Macarrão", Quantity(500, QuantityUnit.GRAM)),
  Product("Leite", Quantity(4, QuantityUnit.LITER)),
  Product("Açúcar", Quantity(2, QuantityUnit.KILOGRAM)),
  Product("Banana", Quantity(12, QuantityUnit.UNIT)),
  Product("Tomate", Quantity(8, QuantityUnit.UNIT)),
  Product("Queijo", Quantity(500, QuantityUnit.GRAM)),
  Product("Maçã", Quantity(10, QuantityUnit.UNIT)),
  Product("Milho", Quantity(500, QuantityUnit.GRAM)),
  Product("Ervilha", Quantity(500, QuantityUnit.GRAM)),
  Product("Massa de lasanha", Quantity(500, QuantityUnit.GRAM)),
  Product("Presunto", Quantity(500, QuantityUnit.GRAM)),
  Product("Queijo ralado", Quantity(500, QuantityUnit.GRAM)),
];

final List<Product> productsList2 = [
  Product("Ovos", Quantity(12, QuantityUnit.UNIT)),
  Product("Macarrão", Quantity(500, QuantityUnit.GRAM)),
  Product("Café", Quantity(200, QuantityUnit.MILLILITER)),
  Product("Arroz", Quantity(2, QuantityUnit.KILOGRAM)),
  Product("Leite", Quantity(4, QuantityUnit.LITER)),
  Product("Açúcar", Quantity(2, QuantityUnit.KILOGRAM)),
  Product("Banana", Quantity(12, QuantityUnit.UNIT)),
  Product("Tomate", Quantity(8, QuantityUnit.UNIT)),
  Product("Queijo", Quantity(500, QuantityUnit.GRAM)),
];

//dart project

final List<Recipe> recipesList = [
  Recipe(
    "Lasanha",
    "assets/images/lasanha.jpg",
    [productsList[13], productsList[14], productsList[15]],
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
  [productsList[4],
    productsList[1],
    productsList[8],
    productsList[9],
    productsList[11]],
    [
      "Em uma panela, leve a carne moída temperada ao fogo e adicione o milho verde e a ervilha.",
      "Misture tudo e deixe cozinhar por 30 minutos.",
      "Desligue o fogo e acrescente o creme de leite e o molho de tomate.",
      "Misture bem e reserve.",
    ],
    DurationTime(30, TimeUnit.MINUTES)
    ),
  Recipe(
    "Bolo de Maçã",
    "assets/images/bolo_de_maca.jpg",
    [productsList[10], productsList[5], productsList[6]],
    [
      "Bata no liquidificador os ovos, o óleo, o açúcar e as maçãs.",
      "Em uma tigela, misture a farinha de trigo e o fermento.",
      "Despeje a mistura do liquidificador na tigela e misture bem.",
      "Coloque em uma forma untada e leve ao forno por 40 minutos."
    ],
    DurationTime(1, TimeUnit.HOURS)
  ),

];
