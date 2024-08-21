import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfridge/services/test_values.dart';
import 'package:smartfridge/utils/quantity.dart';

import '../models/product.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

final List<Product> products = productsList2;
final List<String> unitOptions = Quantity.getUnits();

class _ShoppingListPage extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Shopping list"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("Quantidade: ${product.amount}"),
              trailing: IconButton(
                icon: const Icon(Icons.attach_money),
                color: Colors.green,
                onPressed: () {
                  _showConfirmationDialog(context, product);
                },
              ),
              onTap: () {
                _showProductModal(context, product);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryFixedVariant,
        foregroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}

void _showProductModal(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text("Produto"),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      initialValue: product.name,
                      autocorrect: true,
                      decoration: const InputDecoration(labelText: "Nome"),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: product.amount.value.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              product.amount = Quantity(
                                  double.tryParse(value) ??
                                      product.amount.value,
                                  product.amount.unit);
                            },
                            decoration:
                                const InputDecoration(labelText: "Quantidade"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: DropdownButton<String>(
                            value: unitOptions.contains(product.amount.unit
                                    .toString()
                                    .split('.')
                                    .last)
                                ? product.amount.unit.toString().split('.').last
                                : null,
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  product.amount.unit =
                                      QuantityUnit.values.firstWhere(
                                    (unit) =>
                                        unit.toString().split('.').last ==
                                        newValue,
                                    orElse: () => QuantityUnit
                                        .unit, // Provide a default value
                                  );
                                });
                              }
                            },
                            items: unitOptions.map((unit) {
                              return DropdownMenuItem<String>(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    },
  );
}

void _showConfirmationDialog(BuildContext context, Product product) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: Text("Item Comprado!"),
        ),
        content: Text(
            "${product.amount} de ${product.name} ${product.amount.value > 1 ? 'foram' : 'foi'} movidos para o estoque."),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
