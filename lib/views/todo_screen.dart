import 'package:desafio_tecnico/core/components/app_scaffold.dart';
import 'package:desafio_tecnico/stores/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../core/components/app_privacidade.dart';
import '../core/components/app_textformfield.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required TodoStore todoStore})
      : _todoStore = todoStore;
  final TodoStore _todoStore;
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    widget._todoStore.fetchTodoList();
    widget._todoStore.editingController = TextEditingController();
    focus.addListener(() {
      focus.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    widget._todoStore.editingController.dispose();
    focus.removeListener(() {});
    super.dispose();
  }

  _submit(e) {
    widget._todoStore.submitForm();
    widget._todoStore.editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _CardListView(
              list: widget._todoStore.listTodo,
            ),
            const Spacer(),
            AppTextFormField(
              formFieldKey: widget._todoStore.key,
              focusNode: focus,
              autofocus: true,
              editingController: widget._todoStore.editingController,
              onChanged: widget._todoStore.setTodoTitle,
              validator: widget._todoStore.validateTodoTitle,
              hintText: "Digite seu Texto",
              onFieldSubmitted: _submit,
            ),
            const Spacer(),
            const AppPrivacidade()
          ],
        ),
      ),
    ));
  }
}

class _CardListView extends StatelessWidget {
  const _CardListView({
    required this.list,
  });

  final List<Todo> list;

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<TodoStore>();
    return SizedBox(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        child: Observer(builder: (_) {
          if (store.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                return TodoTile(todo: list[index]);
              });
        }),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<TodoStore>();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            onPressed: () async {
              store.setSelectedToEdit(todo);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text(
                          "Deseja mesmo deletar?",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              store.deleteTodo(todo);
                              Navigator.pop(context);
                            },
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
                      ));
            },
            icon: const Icon(Icons.delete, color: Colors.red))
      ]),
      title: Text(todo.title),
    );
  }
}
