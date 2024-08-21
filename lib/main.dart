import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/app.dart';
import 'package:smartfridge/repository/fridge_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FridgeRepository()),
      ],
      child: const SmartFridgeApp(),
    ),
  );
}