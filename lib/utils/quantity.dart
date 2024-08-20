enum QuantityUnit {
  UNIT,
  GRAM,
  KILOGRAM, // 1 kilogram = 1000 grams
  TEASPOON, // 1 teaspoon = 5 grams
  TABLESPOON, // 1 tablespoon = 15 grams
  CUP, // 1 cup = 240 grams
  MILLILITER, // 1 milliliter = 1 gram
  LITER, // 1 liter = 1000 milliliters
}

class Quantity {
  double value;
  QuantityUnit unit;

  Quantity(this.value, this.unit);

  _singularOrPlural(double value, String unit) {
    if (value < 2) {
      return "${value} ${unit}";
    }
    return '${value} ${unit}s';
  }

  @override
  String toString() {
    switch (unit) {
      case QuantityUnit.UNIT:
        return _singularOrPlural(this.value, 'unidade');
      case QuantityUnit.GRAM:
        return _singularOrPlural(this.value, 'grama');
      case QuantityUnit.KILOGRAM:
        return _singularOrPlural(this.value, 'quilograma');
      case QuantityUnit.TEASPOON:
        return _singularOrPlural(this.value, 'colher de chá');
      case QuantityUnit.TABLESPOON:
        return _singularOrPlural(this.value, 'colher de sopa');
      case QuantityUnit.CUP:
        return _singularOrPlural(this.value, 'xícara');
      case QuantityUnit.MILLILITER:
        return _singularOrPlural(this.value, 'mililitro');
      case QuantityUnit.LITER:
        return _singularOrPlural(this.value, 'litro');
      default:
        return 'unidade(s)';
    }
  }

  // return a list of all units
  static List<String> getUnits() {
    return QuantityUnit.values.map((unit) => unit.toString().split('.').last).toList();
  }
}