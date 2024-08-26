import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryFixedVariant,
        foregroundColor: Colors.white,
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}