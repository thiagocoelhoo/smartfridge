final measure = {
  'unidades': 'Unidade(s)',
  'mililitros': '(ml)',
  'litros': '(L)',
  'gramas': '(g)',
  'quilogramas': '(Kg)',
};

final measureList = measure.entries.map((entry) => '${entry.key}: ${entry.value}').toList();