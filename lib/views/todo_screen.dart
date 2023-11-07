import 'package:desafio_tecnico/core/components/app_scaffold.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("click"),
    ));
  }
}
