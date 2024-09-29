import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/app.dart';
import 'package:smartfridge/repository/db.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/recipes_repository.dart';
import 'package:smartfridge/repository/shopping_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.database; // Inicializar o banco de dados
  final fridgeRepository = FridgeRepository();
  await fridgeRepository.loadProducts();
  final shoppingRepository = ShoppingRepository();
  await shoppingRepository.loadShoppingList();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => fridgeRepository),
        ChangeNotifierProvider(create: (_) => RecipesRepository()),
        ChangeNotifierProvider(create: (_) => shoppingRepository),
      ],
      child: SmartFridgeApp(),
    ),
  );
}