import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onTertiaryFixedVariant,
        foregroundColor: Colors.white,
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}