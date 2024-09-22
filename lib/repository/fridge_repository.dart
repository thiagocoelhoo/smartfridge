import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/db.dart';
import '../utils/quantity.dart';

class FridgeRepository with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    final db = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('fridge');

    _products = List.generate(maps.length, (i) {
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
    await db.insert('fridge', product.toMap());
    _products.add(product);
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    final db = await DB.instance.database;
    await db.delete('fridge', where: 'id = ?', whereArgs: [product.id]);
    _products.remove(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final db = await DB.instance.database;
    await db.update('fridge', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  bool hasInTheFridge(List<Product> ingredients) {
    for (var ingredient in ingredients) {
      if (!_products.contains(ingredient)) {
        return false;
      }
    }
    return true;
  }

  bool containsEnough(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      return _products[index].amount.value >= product.amount.value;
    }
    return false;
  }

  List<Product> getProductsByName(String name) {
    return _products
        .where((p) => p.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}