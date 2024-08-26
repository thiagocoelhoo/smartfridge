import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/controllers/shopping_controller.dart';

class ShoppingRepository extends ChangeNotifier {
  final ShoppingController _controller = ShoppingController();

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

  void clear() {
    _controller.clear();
    notifyListeners();
  }
}