import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfridge/repository/shopping_repository.dart';
import 'package:smartfridge/utils/quantity.dart';
import 'package:smartfridge/models/product.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/widgets/custom_snackbar.dart';

class AddShoppingPage extends StatefulWidget {
  final void Function(BuildContext, Product) onSave;

  const AddShoppingPage({super.key, required this.onSave});

  @override
  AddItemsFridgePageState createState() => AddItemsFridgePageState();
}

class AddItemsFridgePageState extends State<AddShoppingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<String> items = Quantity.getUnits();
  String _selectedUnit = Quantity.getUnits()[0];

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
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
            _buildTextField("Nome", "Insira o nome do produto",
                controller: _nameController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField("Quantidade", "Insira a quantidade",
                      digitsOnly: true, controller: _quantityController),
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildDropdownField("Unidade(s)", items)),
              ],
            ),
            const SizedBox(height: 16),
            _buildDateField(context),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveProduct(context);
              },
              child: const Text("Salvar Produto"),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      title: const Center(child: Text("Add product")),
    );
  }

  void _saveProduct(BuildContext context) {
    final String name = _nameController.text;
    final double quantity = double.tryParse(_quantityController.text) ?? 0;
    final String unit = _selectedUnit;

    if (name.isNotEmpty && quantity > 0) {
      final shoppingRepository =
          Provider.of<ShoppingRepository>(context, listen: false);
      final existingProduct = shoppingRepository.products.firstWhere(
        (product) => product.name.toLowerCase() == name.toLowerCase(),
        orElse: () => Product('', Quantity(0, QuantityUnit.values.first)),
      );

      if (existingProduct.name.isNotEmpty) {
        customSnackBar(
          context,
          "Produto com o mesmo nome já existe",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        final product = Product(
            name,
            Quantity(
                quantity,
                QuantityUnit.values
                    .firstWhere((e) => e.toString() == 'QuantityUnit.$unit')));
        widget.onSave(context, product);
        customSnackBar(
          context,
          "Produto salvo com sucesso",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          duration: const Duration(seconds: 2),
        );
        Navigator.pop(context);
      }
    } else {
      customSnackBar(
        context,
        "Preencha os campos os campos corretamente",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Widget _buildTextField(String label, String hintText,
      {bool digitsOnly = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      keyboardType: digitsOnly ? TextInputType.number : TextInputType.text,
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
            controller.clear();
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
