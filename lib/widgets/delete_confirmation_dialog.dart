import 'package:flutter/material.dart';

void DeleteConfirmationDialog(BuildContext context, void Function() onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text("Confirmação")),
        content: const Text("Tem certeza que deseja excluir este item?"),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: const Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
