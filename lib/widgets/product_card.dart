import 'package:flutter/material.dart';
import 'package:smartfridge/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(BuildContext, Product) onProductTap;
  final void Function(BuildContext, Product)? onProductAction;
  final Icon? customIcon;
  final Color? iconColor;
  final bool showTrailing;

  const ProductCard({
    super.key,
    required this.product,
    required this.onProductTap,
    this.onProductAction,
    this.customIcon,
    this.iconColor,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text("Quantidade: ${product.amount}"),
        trailing: showTrailing && onProductAction != null
            ? IconButton(
          icon: customIcon ?? const Icon(Icons.attach_money),
          color: iconColor ?? Colors.green,
          onPressed: () {
            onProductAction!(context, product);
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