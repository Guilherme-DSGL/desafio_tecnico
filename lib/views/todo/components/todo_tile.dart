import 'package:flutter/material.dart';

import '../../../models/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    this.onDeletePressed,
    this.onEditPressed,
  });

  final Todo todo;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            onPressed: onEditPressed,
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete, color: Colors.red))
      ]),
      title: Text(todo.title),
    );
  }
}
