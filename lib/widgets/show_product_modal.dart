import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/utils/quantity.dart';

void showProductModal(BuildContext context, Product product) {
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
                            value: Quantity.getUnits().contains(product.amount.unit
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
                                        orElse: () => QuantityUnit.unit,
                                      );
                                });
                              }
                            },
                            items: Quantity.getUnits().map((unit) {
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