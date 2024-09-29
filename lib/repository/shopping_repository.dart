import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/db.dart';
import '../utils/quantity.dart';

class ShoppingRepository with ChangeNotifier {
  List<Product> _shoppingList = [];

  List<Product> get shoppingList => _shoppingList;

  Future<void> loadShoppingList() async {
    final db = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('shopping_list');

    _shoppingList = List.generate(maps.length, (i) {
      return Product(
        maps[i]['name'],
        Quantity(
          maps[i]['amount_value'],
          QuantityUnit.values.firstWhere(
              (e) => e.toString() == 'QuantityUnit.${maps[i]['amount_unit']}'),
        ),
        id: maps[i]['id'],
      );
    });

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final db = await DB.instance.database;
    await db.insert('shopping_list', product.toMap());
    _shoppingList.add(product);
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    final db = await DB.instance.database;
    await db.delete('shopping_list', where: 'id = ?', whereArgs: [product.id]);
    _shoppingList.remove(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final db = await DB.instance.database;
    await db.update('shopping_list', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
    final index = _shoppingList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _shoppingList[index] = product;
      notifyListeners();
    }
  }

  List<Product> get products => _shoppingList;
}