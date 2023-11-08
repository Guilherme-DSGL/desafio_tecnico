import 'package:desafio_tecnico/core/components/app_scaffold.dart';
import 'package:desafio_tecnico/stores/todo/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/components/app_privacidade.dart';
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

  @override
  void initState() {
    widget._todoStore.fetchTodoList();
    _editingController = TextEditingController();
    focus = FocusNode();
    _setup();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    focus.dispose();
    super.dispose();
  }

  _setup() {
    widget._todoStore.formTodo.setupValidations();
    focus.addListener(() {
      focus.requestFocus();
    });
  }

  _submit(e) {
    widget._todoStore.formTodo.validateAll();
    if (widget._todoStore.formTodo.isFormValid) {
      widget._todoStore.submitForm();
      _editingController.clear();
      widget._todoStore.formTodo.resetErrors();
    }
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
                    final item = widget._todoStore.listTodo[index];
                    return Observer(builder: (_) {
                      return TodoTile(
                          isSelected: widget._todoStore.formTodo
                              .selectedToEditHasMatch(item),
                          todo: item,
                          onEditPressed: () {
                            widget._todoStore.formTodo.setSelectedToEdit(item);
                            _updateEdditingController(item.title);
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
                  });
            }),
            const Spacer(),
            Observer(builder: (_) {
              return TextFormField(
                focusNode: focus,
                autofocus: true,
                controller: _editingController,
                onChanged: widget._todoStore.formTodo.setTodoTitle,
                decoration: InputDecoration(
                    hintText: "Digite seu Texto",
                    errorText: widget._todoStore.formTodo.errors.titleError,
                    suffixIcon: Visibility(
                      visible: widget._todoStore.isValidForUpdate,
                      child: IconButton(
                        icon: const Icon(Icons.edit_off),
                        color: Colors.redAccent,
                        onPressed: () {
                          widget._todoStore.formTodo.resetForm();
                          _editingController.clear();
                          widget._todoStore.formTodo.resetErrors();
                        },
                      ),
                    )),
                onFieldSubmitted: _submit,
              );
            }),
            const Spacer(),
            const AppPrivacidade()
          ],
        ),
      ),
    ));
  }
}
