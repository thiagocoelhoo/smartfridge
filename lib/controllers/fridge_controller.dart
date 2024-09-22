import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';

class FridgeController extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    _products.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  bool containsEnough(Product product) {
    final index = _products.indexWhere((p) => p.name == product.name);
    if (index == -1) return false;
    return _products[index].amount >= product.amount;
  }
}