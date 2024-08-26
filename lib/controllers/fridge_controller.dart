import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/utils/quantity.dart';

class FridgeController {
  final List<Product> _products = [];

  FridgeController() {
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
      _products[index].amount.add(product.amount);
    } else {
      _products.add(product);
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

  bool containsEnough(Product product) {
    final index =
        _products.indexWhere((element) => element.name == product.name);
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
