import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';

import '../utils/quantity.dart';

class ShoppingRepository extends ChangeNotifier {
  final List<Product> _products = [];

  ShoppingRepository() {
    _loadInitialProducts();
  }

  List<Product> get products => List.unmodifiable(_products);

  List<Product> getProductsByName(String name) {
    return _products.where((element) => name.contains(element.name)).toList();
  }

  addProduct(Product product) {
    final index =
        _products.indexWhere((element) => element.name == product.name);
    if (index != -1) {
      _products[index].amount.value += product.amount.value;
    } else {
      _products.add(product);
    }
    notifyListeners();
  }

  removeProduct(Product product) {
    if (_products.contains(product)) {
      _products.remove(product);
      notifyListeners();
    }
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _products[index].name = product.name;
      _products[index].amount = product.amount;
      notifyListeners();
    } else {
      // TODO: Handle error
    }
  }

  clear() {
    _products.clear();
    notifyListeners();
  }

  void _loadInitialProducts() {
    _products.addAll([
      Product("Arroz", Quantity(1, QuantityUnit.kilogram)),
      Product("Feijão", Quantity(1, QuantityUnit.kilogram)),
      Product("Carne", Quantity(1, QuantityUnit.kilogram)),
    ]);
  }
}
