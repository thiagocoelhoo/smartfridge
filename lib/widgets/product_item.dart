import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final ValueNotifier<bool> isSelectedNotifier;
  final void Function(BuildContext, Product) onProductTap;
  final void Function(BuildContext, Product)? onLeadingAction;
  final void Function(BuildContext, Product)? onTrailingAction;
  final void Function(bool)? onChangeCheckbox;

  const ProductItem({
    super.key,
    required this.product,
    required this.isSelectedNotifier,
    required this.onProductTap,
    this.onLeadingAction,
    this.onTrailingAction,
    this.onChangeCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text("Quantidade: ${product.amount}"),
        leading: onChangeCheckbox != null
            ? ValueListenableBuilder<bool>(
                valueListenable: isSelectedNotifier,
                builder: (context, isSelected, child) {
                  return Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      isSelectedNotifier.value = value ?? false;
                      if (onLeadingAction != null) {
                        onLeadingAction!(context, product);
                      }
                      if (onChangeCheckbox != null) {
                        onChangeCheckbox!(isSelectedNotifier.value);
                      }
                    },
                  );
                },
              )
            : null,
        trailing: onTrailingAction != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                color: Colors.redAccent,
                onPressed: () {
                  onTrailingAction!(context, product);
                },
              )
            : null,
        onTap: () {
          onProductTap(context, product);
        },
      ),
    );
  }
}
