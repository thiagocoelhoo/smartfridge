import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/fridge_repository.dart';
import 'package:smartfridge/utils/quantity.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _amountValue;
  late QuantityUnit _amountUnit;

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _amountValue = widget.product.amount.value;
    _amountUnit = widget.product.amount.unit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _amountValue.toString(),
                decoration: InputDecoration(labelText: 'Amount Value'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amountValue = double.parse(value!);
                },
              ),
              DropdownButtonFormField<QuantityUnit>(
                value: _amountUnit,
                decoration: InputDecoration(labelText: 'Amount Unit'),
                items: QuantityUnit.values.map((QuantityUnit unit) {
                  return DropdownMenuItem<QuantityUnit>(
                    value: unit,
                    child: Text(unit.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (QuantityUnit? newValue) {
                  setState(() {
                    _amountUnit = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedProduct = Product(
                      _name,
                      Quantity(_amountValue, _amountUnit),
                      id: widget.product.id,
                    );
                    Provider.of<FridgeRepository>(context, listen: false)
                        .updateProduct(updatedProduct);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
