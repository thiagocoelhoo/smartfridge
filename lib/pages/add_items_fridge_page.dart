import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfridge/utils.dart';
import 'package:smartfridge/utils/quantity.dart';

class AddItemsFridgePage extends StatefulWidget {
  const AddItemsFridgePage({super.key});

  @override
  _AddItemsFridgePageState createState() => _AddItemsFridgePageState();
}

class _AddItemsFridgePageState extends State<AddItemsFridgePage> {
  final TextEditingController _dateController = TextEditingController();
  final List<String> items = Quantity.getUnits();
  String _selectedUnit = Quantity.getUnits()[0];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTextField("Nome", "Insira o nome do produto"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          "Quantidade", "Insira a quantidade",
                          digitsOnly: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDropdownField("Unidade(s)", items)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField("Icone", "Selecione um ícone"),
              const SizedBox(height: 16),
              _buildDateField(context),
            ],
          ),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: const Center(child: Text("Add product")),
    );
  }

  Widget _buildTextField(String label, String hintText,
      {bool digitsOnly = false}) {
    TextEditingController textController = TextEditingController();

    return TextField(
      controller: textController,
      keyboardType: TextInputType.number,
      inputFormatters:
          digitsOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            textController.clear();
          },
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      value: _selectedUnit,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      items: items.map((String unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedUnit = newValue!;
        });
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Data de validade",
        hintText: "MM/DD/YYYY",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (selectedDate != null) {
              setState(() {
                _dateController.text = _formatDate(selectedDate);
              });
            }
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddItemsFridgePage(),
  ));
}
