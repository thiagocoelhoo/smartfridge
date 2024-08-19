import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage();

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

class Product {
  String name;
  int amount;
  String? unit;

  Product(this.name, this.amount, this.unit);
}

final List<Product> products = [
  Product("Ovos", 30, "Unidade(s)"),
  Product("Macarrão", 2, "Kg"),
  Product("Café", 1, "L"),
  Product("Arroz", 5, "Kg"),
  Product("Feijão", 3, "Kg"),
  Product("Leite", 4, "L"),
  Product("Açúcar", 2, "Kg"),
  Product("Banana", 12, "Unidade(s)"),
  Product("Tomate", 8, "Unidade(s)"),
  Product("Queijo", 500, "g"),
  Product("Maçã", 10, "Unidade(s)"),
];
final List<String> unitOptions = ["Unidade(s)", "Kg", "g", "L", "ml"];


class _ShoppingListPage extends State<ShoppingListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: Text("Shopping list"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("Quantidade: ${product.amount} ${product.unit}"),
              trailing: IconButton(
                icon: Icon(Icons.attach_money),
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
      )
      ,
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
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text("Produto"),
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      initialValue: product.name,
                      autocorrect: true,
                      decoration: InputDecoration(labelText: "Nome"),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: product.amount.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              product.amount = int.tryParse(value) ?? product.amount;
                            },
                            decoration: InputDecoration(labelText: "Quantidade"),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: DropdownButton<String>(
                            value: product.unit,
                            onChanged: (newValue) {
                              setState(() {
                                product.unit = newValue;
                              });
                            },
                            items: unitOptions.map((unit) {
                              return DropdownMenuItem<String>(
                                value: unit,
                                child: Text(" " + unit),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Salvar"),
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
        title: Center(child: Text("Item Comprado!"),),
        content: Text(
            "${product.amount} ${product.unit} ${product.name} ${product.amount > 1 ? 'foram' : 'foi'} movidos para o estoque."
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}


