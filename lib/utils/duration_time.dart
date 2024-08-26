import 'package:smartfridge/utils/utils.dart';

enum TimeUnit {
  seconds,
  minutes,
  hours,
  days,
}

class DurationTime {
  final double value;
  final TimeUnit unit;

  DurationTime(this.value, this.unit);

  @override
  String toString() {
    switch (unit) {
      case TimeUnit.seconds:
        return singularOrPlural(value, 'segundo');
      case TimeUnit.minutes:
        return singularOrPlural(value, 'minuto');
      case TimeUnit.hours:
        return singularOrPlural(value, 'hora');
      case TimeUnit.days:
        return singularOrPlural(value, 'dia');
      default:
        return 'unidade(s)';
    }
  }

  String abreviation() {
    switch (unit) {
      case TimeUnit.seconds:
        return '$value s';
      case TimeUnit.minutes:
        return '$value min';
      case TimeUnit.hours:
        return '$value h';
      case TimeUnit.days:
        return '$value d';
      default:
        return '$value u';
    }
  }
}

