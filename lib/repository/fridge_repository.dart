import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/controllers/fridge_controller.dart';

class FridgeRepository extends ChangeNotifier {
  final FridgeController _controller = FridgeController();

  List<Product> get products => _controller.products;

  List<Product> getProductsByName(String name) {
    return _controller.getProductsByName(name);
  }

  void addProduct(Product product) {
    _controller.addProduct(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _controller.removeProduct(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    _controller.updateProduct(product);
    notifyListeners();
  }

  bool containsEnough(Product product) {
    return _controller.containsEnough(product);
  }

  int hasInTheFridge(List<Product> products) {
    return _controller.hasInTheFridge(products);
  }

  void clear() {
    _controller.clear();
    notifyListeners();
  }
}