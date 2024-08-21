import 'package:smartfridge/utils/utils.dart';

enum QuantityUnit {
  unit,
  gram,
  kilogram, // 1 kilogram = 1000 grams
  teaspoon, // 1 teaspoon = 5 grams
  tablespoon, // 1 tablespoon = 15 grams
  cup, // 1 cup = 240 grams
  milliliter, // 1 milliliter = 1 gram
  liter, // 1 liter = 1000 milliliters
}

class Quantity {
  double value;
  QuantityUnit unit;

  Quantity(this.value, this.unit);

  @override
  String toString() {
    switch (unit) {
      case QuantityUnit.unit:
        return singularOrPlural(value, 'unidade');
      case QuantityUnit.gram:
        return singularOrPlural(value, 'grama');
      case QuantityUnit.kilogram:
        return singularOrPlural(value, 'quilograma');
      case QuantityUnit.teaspoon:
        return singularOrPlural(value, 'colher de chá');
      case QuantityUnit.tablespoon:
        return singularOrPlural(value, 'colher de sopa');
      case QuantityUnit.cup:
        return singularOrPlural(value, 'xícara');
      case QuantityUnit.milliliter:
        return singularOrPlural(value, 'mililitro');
      case QuantityUnit.liter:
        return singularOrPlural(value, 'litro');
      default:
        return 'unidade(s)';
    }
  }

  // return a list of all units
  static List<String> getUnits() {
    return QuantityUnit.values.map((unit) => unit.toString().split('.').last).toList();
  }
}