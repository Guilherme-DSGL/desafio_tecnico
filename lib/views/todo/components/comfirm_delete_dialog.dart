import 'package:flutter/material.dart';

class ConfimDeleteAlertDialog extends StatelessWidget {
  const ConfimDeleteAlertDialog({super.key, required this.onDeletePressed});

  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Deseja mesmo deletar?",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: onDeletePressed,
          child: const Text(
            "Deletar",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Não"))
      ],
    );
  }
}
