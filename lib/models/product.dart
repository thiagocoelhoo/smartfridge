import 'package:uuid/uuid.dart';
import '../utils/quantity.dart';

class Product {
  final String id;
  String _name;
  Quantity _amount;

  Product(this._name, this._amount, {String? id})
      : id = id ?? const Uuid().v4();

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  Quantity get amount => _amount;

  set amount(Quantity amount) {
    _amount = amount;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': _name,
      'amount_value': _amount.value,
      'amount_unit': _amount.unit.toString().split('.').last,
    };
  }
}