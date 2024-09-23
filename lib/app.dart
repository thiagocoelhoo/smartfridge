import 'package:flutter/material.dart';
import 'package:smartfridge/pages/my_fridge_page.dart';
import 'package:smartfridge/pages/supermarkets_page.dart';
import 'package:smartfridge/pages/recipes_page.dart';
import 'package:smartfridge/pages/shopping_list_page.dart';

class SmartFridgeApp extends StatelessWidget {
  SmartFridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartFridge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey,
            brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Smart Fridge'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    MyFridgePage(),
    const RecipesPage(),
    const ShoppingListPage(),
    NearbySupermarketsPage(),
  ];

  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: "Fridge"
          ),
          NavigationDestination(
              icon: Icon(Icons.library_books),
              label: "Recipes"
          ),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: "Shopping list"),
          NavigationDestination(icon: Icon(Icons.store), label: "Supermarket"),
        ],
      ),
    );
  }
}