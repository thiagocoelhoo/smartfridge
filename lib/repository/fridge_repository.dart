import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';

import '../utils/quantity.dart';

class FridgeRepository extends ChangeNotifier {
  final List<Product> _products = [];

  FridgeRepository() {
    _loadInitialProducts();
  }

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    final index = _products.indexWhere((element) => element.name == product.name);
    if (index != -1) {
      _products[index].amount.value += product.amount.value;
    } else {
      _products.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_products.contains(product)) {
      _products.remove(product);
      notifyListeners();
    }
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((element) => element.name == product.name);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  bool containsEnough(Product product) {
    final index = _products.indexWhere((element) => element.name == product.name);
    if (index == -1) {
      return false;
    }
    return _products[index].amount.value >= product.amount.value;
  }

  int hasInTheFridge(List<Product> products) {
    int count = 0;
    for (final product in products) {
      if (containsEnough(product)) {
        count++;
      }
    }
    return count;
  }

  void clear() {
    _products.clear();
    notifyListeners();
  }

  void _loadInitialProducts() {
    _products.addAll([
      Product("Pão", Quantity(10, QuantityUnit.unit)),
      Product("Carne", Quantity(1, QuantityUnit.kilogram)),
      Product("Café", Quantity(200, QuantityUnit.milliliter)),
      Product("Arroz", Quantity(2, QuantityUnit.kilogram)),
      Product("Macarrão", Quantity(500, QuantityUnit.gram)),
      Product("Massa de lasanha", Quantity(500, QuantityUnit.gram)),
      Product("Presunto", Quantity(500, QuantityUnit.gram)),
      Product("Queijo ralado", Quantity(500, QuantityUnit.gram)),
    ]);
  }
}
