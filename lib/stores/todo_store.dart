import 'package:desafio_tecnico/core/constants/keys.dart';
import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/todo.dart';
part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  final LocalDbService _localDbService;
  TodoStoreBase(this._localDbService);

  late TextEditingController editingController;
  final key = GlobalKey<FormFieldState>();
  @observable
  String todoTitle = "";

  @observable
  Todo? selectedToEdit;

  @observable
  bool isBusy = false;

  @action
  setTodoTitle(String todoTitle) => this.todoTitle = todoTitle;
  @action
  setSelectedToEdit(Todo todo) {
    setTodoTitle(todo.title);
    updateEdditingController(todo.title);
    selectedToEdit = todo;
  }

  updateEdditingController(String title) {
    editingController.clear();

    editingController.value = editingController.value.copyWith(
      text: title,
      selection: TextSelection.fromPosition(
        TextPosition(offset: title.length),
      ),
    );
  }

  String? validateTodoTitle(String? s) {
    if (!isTodoTitleValid) {
      return "Digite um Texto";
    }
    return null;
  }

  @computed
  bool get isTodoTitleValid => todoTitle.isNotEmpty;

  @computed
  bool get isSelectTodo =>
      selectedToEdit != null && listTodo.contains(selectedToEdit);

  @computed
  bool get isFormValid => isTodoTitleValid;

  @action
  submitForm() {
    if (!isFormValid) {
      return;
    }
    if (isSelectTodo) {
      editTodo();
      todoTitle = "";
    } else {
      saveTodo(todoTitle);
      todoTitle = "";
    }
  }

  @observable
  ObservableList<Todo> listTodo = ObservableList<Todo>();

  @action
  fetchTodoList() {
    final result = _localDbService.getListString(key: kTodo);
    if (result != null) {
      listTodo.addAll(Todo.listFromJsonList(result));
    }
  }

  @action
  editTodo() async {
    int i = listTodo.indexOf(selectedToEdit);
    if (i != -1) {
      listTodo[i] = Todo(title: todoTitle);
      await _localDbService
          .insertListString(key: kTodo, value: Todo.listToJsonList(listTodo))
          .then((value) => listTodo);
    }
  }

  @action
  saveTodo(String text) async {
    isBusy = true;
    await _localDbService
        .insertListString(key: kTodo, value: Todo.listToJsonList(listTodo))
        .then((value) => listTodo.add(Todo(title: text)));
    isBusy = false;
  }

  @action
  deleteTodo(Todo todo) async {
    isBusy = true;
    listTodo.removeWhere((element) => todo.hashCode == element.hashCode);
    await _localDbService.insertListString(
        key: kTodo, value: Todo.listToJsonList(listTodo));
    isBusy = false;
  }
}
