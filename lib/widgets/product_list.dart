import 'package:flutter/material.dart';
import 'package:smartfridge/widgets/product_card.dart';
import '../models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final void Function(BuildContext, Product) onProductTap;
  final void Function(BuildContext, Product)? onProductAction;
  final bool showTrailing;
  final Icon? customIcon;
  final Color? iconColor;


  const ProductList({
    super.key,
    required this.products,
    required this.onProductTap,
    this.onProductAction,
    this.showTrailing = false,
    this.customIcon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      children: products.map((product) {
        return ProductCard(
            product: product,
            onProductTap: onProductTap,
            onProductAction: onProductAction,
            showTrailing: showTrailing,
            customIcon: customIcon,
            iconColor: iconColor,
        );
      }).toList(),
    );
  }
}