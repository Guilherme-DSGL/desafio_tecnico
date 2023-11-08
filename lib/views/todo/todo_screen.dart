import 'package:desafio_tecnico/core/components/app_scaffold.dart';
import 'package:desafio_tecnico/stores/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/components/app_privacidade.dart';
import '../../core/components/app_textformfield.dart';
import 'components/card_listview.dart';
import 'components/comfirm_delete_dialog.dart';
import 'components/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required TodoStore todoStore})
      : _todoStore = todoStore;
  final TodoStore _todoStore;
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late FocusNode focus;
  late TextEditingController _editingController;

  final key = GlobalKey<FormFieldState>();

  @override
  void initState() {
    widget._todoStore.fetchTodoList();
    _editingController = TextEditingController();
    focus = FocusNode();
    focus.addListener(() {
      focus.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    focus.dispose();
    super.dispose();
  }

  _submit(e) {
    widget._todoStore.submitForm();
    _editingController.clear();
  }

  _updateEdditingController(String title) {
    _editingController.clear();

    _editingController.value = _editingController.value.copyWith(
      text: title,
      selection: TextSelection.fromPosition(
        TextPosition(offset: title.length),
      ),
    );
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
            Observer(builder: (_) {
              return CardListView(
                  isLoading: widget._todoStore.isBusy,
                  itemCount: widget._todoStore.listTodo.length,
                  itemBuilder: (_, index) {
                    return TodoTile(
                        todo: widget._todoStore.listTodo[index],
                        onEditPressed: () async {
                          widget._todoStore.formTodo.setSelectedToEdit(
                              widget._todoStore.listTodo[index]);
                          _updateEdditingController(
                              widget._todoStore.listTodo[index].title);
                        },
                        onDeletePressed: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                ConfimDeleteAlertDialog(onDeletePressed: () {
                              widget._todoStore.deleteTodo(
                                  widget._todoStore.listTodo[index]);
                              Navigator.pop(context);
                            }),
                          );
                        });
                  });
            }),
            const Spacer(),
            AppTextFormField(
              formFieldKey: key,
              focusNode: focus,
              autofocus: true,
              editingController: _editingController,
              onChanged: widget._todoStore.formTodo.setTodoTitle,
              validator: widget._todoStore.formTodo.validateTodoTitle,
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
