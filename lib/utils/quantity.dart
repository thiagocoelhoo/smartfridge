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

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      json['amount'].toDouble(),
      QuantityUnit.values
          .firstWhere((e) => e.toString().split('.').last == json['unit']),
    );
  }

  bool operator >=(Quantity other) {
    if (unit != other.unit) {
      throw ArgumentError('Cannot compare quantities with different units');
    }
    return value >= other.value;
  }

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

  String abreviation() {
    switch (unit) {
      case QuantityUnit.unit:
        return '$value ${value > 1 ? 'unidades' : 'unidade'}';
      case QuantityUnit.gram:
        return '$value g';
      case QuantityUnit.kilogram:
        return '$value Kg';
      case QuantityUnit.teaspoon:
        return '$value ${value > 1 ? 'colheres' : 'colher'} de chá';
      case QuantityUnit.tablespoon:
        return '$value ${value > 1 ? 'colheres' : 'colher'} de sopa';
      case QuantityUnit.cup:
        return '$value ${value > 1 ? 'xícaras' : 'xícara'}';
      case QuantityUnit.milliliter:
        return '$value ml';
      case QuantityUnit.liter:
        return '$value L';
      default:
        return '$value ${value > 1 ? 'unidades' : 'unidade'}';
    }
  }

  // return a list of all units
  static List<String> getUnits() {
    return QuantityUnit.values
        .map((unit) => unit.toString().split('.').last)
        .toList();
  }

  void add(Quantity other) {
    double convertedValue = other.convertTo(unit);
    value += convertedValue;
  }

  // Método de conversão existente
  double convertTo(QuantityUnit newUnit) {
    if (unit == newUnit) {
      return value;
    }

    double newValue = value;

    switch (unit) {
      case QuantityUnit.gram:
        newValue = _convertGrams(newValue, newUnit);
        break;
      case QuantityUnit.kilogram:
        newValue = _convertKilograms(newValue, newUnit);
        break;
      case QuantityUnit.teaspoon:
        newValue = _convertTeaspoons(newValue, newUnit);
        break;
      case QuantityUnit.tablespoon:
        newValue = _convertTablespoons(newValue, newUnit);
        break;
      case QuantityUnit.cup:
        newValue = _convertCups(newValue, newUnit);
        break;
      case QuantityUnit.milliliter:
        newValue = _convertMilliliters(newValue, newUnit);
        break;
      case QuantityUnit.liter:
        newValue = _convertLiters(newValue, newUnit);
        break;
      default:
        break;
    }

    return newValue;
  }

  // Métodos de conversão existentes
  double _convertGrams(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.kilogram:
        return value / 1000;
      case QuantityUnit.teaspoon:
        return value / 5;
      case QuantityUnit.tablespoon:
        return value / 15;
      case QuantityUnit.cup:
        return value / 240;
      case QuantityUnit.milliliter:
        return value;
      case QuantityUnit.liter:
        return value / 1000;
      default:
        return value;
    }
  }

  double _convertKilograms(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value * 1000;
      case QuantityUnit.teaspoon:
        return value * 1000 / 5;
      case QuantityUnit.tablespoon:
        return value * 1000 / 15;
      case QuantityUnit.cup:
        return value * 1000 / 240;
      case QuantityUnit.milliliter:
        return value * 1000;
      case QuantityUnit.liter:
        return value;
      default:
        return value;
    }
  }

  double _convertTeaspoons(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value * 5;
      case QuantityUnit.kilogram:
        return value * 5 / 1000;
      case QuantityUnit.tablespoon:
        return value / 3;
      case QuantityUnit.cup:
        return value / 48;
      case QuantityUnit.milliliter:
        return value * 5;
      case QuantityUnit.liter:
        return value * 5 / 1000;
      default:
        return value;
    }
  }

  double _convertTablespoons(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value * 15;
      case QuantityUnit.kilogram:
        return value * 15 / 1000;
      case QuantityUnit.teaspoon:
        return value * 3;
      case QuantityUnit.cup:
        return value / 16;
      case QuantityUnit.milliliter:
        return value * 15;
      case QuantityUnit.liter:
        return value * 15 / 1000;
      default:
        return value;
    }
  }

  double _convertCups(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value * 240;
      case QuantityUnit.kilogram:
        return value * 240 / 1000;
      case QuantityUnit.teaspoon:
        return value * 48;
      case QuantityUnit.tablespoon:
        return value * 16;
      case QuantityUnit.milliliter:
        return value * 240;
      case QuantityUnit.liter:
        return value * 240 / 1000;
      default:
        return value;
    }
  }

  double _convertMilliliters(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value;
      case QuantityUnit.kilogram:
        return value / 1000;
      case QuantityUnit.teaspoon:
        return value / 5;
      case QuantityUnit.tablespoon:
        return value / 15;
      case QuantityUnit.cup:
        return value / 240;
      case QuantityUnit.liter:
        return value / 1000;
      default:
        return value;
    }
  }

  double _convertLiters(double value, QuantityUnit newUnit) {
    switch (newUnit) {
      case QuantityUnit.gram:
        return value * 1000;
      case QuantityUnit.kilogram:
        return value;
      case QuantityUnit.teaspoon:
        return value * 1000 / 5;
      case QuantityUnit.tablespoon:
        return value * 1000 / 15;
      case QuantityUnit.cup:
        return value * 1000 / 240;
      case QuantityUnit.milliliter:
        return value * 1000;
      default:
        return value;
    }
  }
}
