singularOrPlural(double value, String unit) {
  if (value < 2) {
    return "$value $unit";
  }
  return '$value ${unit}s';
}