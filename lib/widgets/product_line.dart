import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/models/product.dart';
import 'package:smartfridge/repository/fridge_repository.dart';

class ProductLine extends StatelessWidget {
  final Product product;
  final void Function(BuildContext, Product)? onTrailingAction;

  const ProductLine({
    super.key,
    required this.product,
    this.onTrailingAction,
  });

  @override
  Widget build(BuildContext context) {
    final fridgeRepository = Provider.of<FridgeRepository>(context);
    final isAvailable = fridgeRepository.containsEnough(product);
    final color = isAvailable ? Colors.white : Colors.red;
    final style = TextStyle(
      color: color,
      decoration: TextDecoration.none,
    );
    final sameProduct = fridgeRepository.getProductsByName(product.name);
    final sameProductAmount =
        sameProduct.isNotEmpty ? sameProduct[0].amount : 0;

    return ListTile(
      title: Text(
        product.name,
        style: style,
      ),
      subtitle: Text(
        "$sameProductAmount/${product.amount} na geladeira",
        style: style,
      ),
      trailing: !isAvailable
          ? IconButton(
              icon: const Icon(Icons.attach_money_rounded),
              color: Colors.green,
              onPressed: () {
                onTrailingAction!(context, product);
              },
            )
          : const Icon(
              Icons.check,
              color: Colors.green,
            ),
    );
  }
}
