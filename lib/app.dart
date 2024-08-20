import 'package:flutter/material.dart';
import 'package:smartfridge/pages/my_fridge_page.dart';
import 'package:smartfridge/pages/recipes_page.dart';
import 'package:smartfridge/pages/shopping_list_page.dart';

class SmartFridgeApp extends StatelessWidget {
  const SmartFridgeApp({super.key});

  // This widget is the root of your application.
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
      home: const HomePage(title: 'Smart Fridge', ),
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
  var pages = <Widget>[
    MyFridgePage(),
    const RecipesPage(),
    const ShoppingListPage(),
  ];

  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _navBar(),
    );
  }

  NavigationBar _navBar() {
    return NavigationBar(
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
            label:  "Recipes"
        ),
        NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label:  "Shopping list"
        )
      ],
    );
  }

  Widget _body() {
    return pages[currentPageIndex];
  }
}
