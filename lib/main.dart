import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/app.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/repository/recipes_repository.dart';
import 'package:smartfridge/repository/shopping_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FridgeRepository()),
        ChangeNotifierProvider(create: (_) => RecipesRepository()),
        ChangeNotifierProvider(create: (_) => ShoppingRepository()),
      ],
      child: const SmartFridgeApp(),
    ),
  );
}