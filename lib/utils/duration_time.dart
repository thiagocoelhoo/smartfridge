enum TimeUnit {
  SECONDS,
  MINUTES,
  HOURS,
  DAYS,
}

class DurationTime {
  final int value;
  final TimeUnit unit;

  DurationTime(this.value, this.unit);

  _singularOrPlural(int value, String unit) {
    if (value < 2) {
      return "${value} ${unit}";
    }
    return '${value} ${unit}s';
  }

  @override
  String toString() {
    switch (unit) {
      case TimeUnit.SECONDS:
        return _singularOrPlural(this.value, 'segundo');
      case TimeUnit.MINUTES:
        return _singularOrPlural(this.value, 'minuto');
      case TimeUnit.HOURS:
        return _singularOrPlural(this.value, 'hora');
      case TimeUnit.DAYS:
        return _singularOrPlural(this.value, 'dia');
      default:
        return 'unidade(s)';
    }
  }
}

