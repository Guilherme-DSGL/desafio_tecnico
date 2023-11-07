import 'package:desafio_tecnico/core/components/app_scaffold.dart';
import 'package:desafio_tecnico/stores/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/components/app_textformfield.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required TodoStore todoStore})
      : _todoStore = todoStore;
  final TodoStore _todoStore;
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _editingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget._todoStore.fetchTodoList();
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  String? _validator(String? s) {
    if (s!.isEmpty) {
      return "Digite um texto";
    }
    return null;
  }

  void _onSubmit(String e) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      widget._todoStore.saveTodo(_editingController.text).then((value) {
        _editingController.clear();
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
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
            SizedBox(
              height: 300,
              width: MediaQuery.sizeOf(context).width,
              child: Card(
                child: Observer(builder: (_) {
                  return ListView.builder(
                      itemCount: widget._todoStore.listTodo.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(widget._todoStore.listTodo[index].title),
                        );
                      });
                }),
              ),
            ),
            const Spacer(),
            Form(
              key: _formKey,
              child: AppTextFormField(
                focusNode: _focusNode,
                editingController: _editingController,
                hintText: "Digite seu Texto",
                validator: _validator,
                onFieldSubmitted: _onSubmit,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Políticas de Privacidade",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
