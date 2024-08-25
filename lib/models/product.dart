import 'package:smartfridge/utils/quantity.dart';
import 'package:uuid/uuid.dart';

class Product {
  final String id;
  String name;
  Quantity amount;

  Product(this.name, this.amount) : id = const Uuid().v4();
}