import 'package:smartfridge/models/product.dart';
import '../utils/quantity.dart';

class ShoppingController {
  final List<Product> _products = [];

  ShoppingController() {
    _loadInitialProducts();
  }

  List<Product> get products => List.unmodifiable(_products);

  List<Product> getProductsByName(String name) {
    return _products
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void addProduct(Product product) {
    final index = _products.indexWhere(
        (element) => element.name.toLowerCase() == product.name.toLowerCase());
    if (index != -1) {
      _products[index].amount.value += product.amount.value;
    } else {
      final clonedProduct = Product(
          product.name, Quantity(product.amount.value, product.amount.unit));
      _products.add(clonedProduct);
    }
  }

  void removeProduct(Product product) {
    if (_products.contains(product)) {
      _products.remove(product);
    }
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((element) => element.id == product.id);
    final nameExists = _products.any((element) =>
        element.name.toLowerCase() == product.name.toLowerCase() &&
        element.id != product.id);
    if (index != -1 && !nameExists) {
      _products[index] = product;
    }
  }

  void clear() {
    _products.clear();
  }

  void _loadInitialProducts() {
    _products.addAll([
      Product("Arroz", Quantity(1, QuantityUnit.kilogram)),
      Product("Feijão", Quantity(3, QuantityUnit.kilogram)),
      Product("Carne", Quantity(1.5, QuantityUnit.kilogram)),
      Product("Macarrão", Quantity(2, QuantityUnit.kilogram)),
      Product("Óleo", Quantity(1, QuantityUnit.liter)),
      Product("Sal", Quantity(1, QuantityUnit.kilogram)),
    ]);
  }
}
