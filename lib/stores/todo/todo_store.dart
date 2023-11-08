import 'package:desafio_tecnico/core/constants/keys.dart';
import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:desafio_tecnico/stores/todo/form/todo_form_store.dart';
import 'package:mobx/mobx.dart';

import '../../models/todo.dart';
part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  final LocalDbService _localDbService;
  TodoStoreBase(this._localDbService);

  final formTodo = TodoFormStore();

  @action
  submitForm() {
    if (isValidForUpdate) {
      editTodo();
      formTodo.resetForm();
    } else {
      saveTodo(formTodo.todoTitle);
      formTodo.resetForm();
    }
  }

  @observable
  bool isBusy = false;

  @observable
  ObservableList<Todo> listTodo = ObservableList<Todo>();

  @computed
  bool get isValidForUpdate =>
      formTodo.isSelectedTodo && listTodo.contains(formTodo.selectedToEdit);

  @action
  fetchTodoList() {
    final result = _localDbService.getListString(key: kTodo);
    if (result != null) {
      listTodo.addAll(Todo.listFromJsonList(result));
    }
  }

  @action
  editTodo() async {
    int i = listTodo.indexOf(formTodo.selectedToEdit);
    if (i != -1) {
      listTodo[i] = Todo(title: formTodo.todoTitle);
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
    listTodo.removeWhere((element) => todo == element);
    await _localDbService.insertListString(
        key: kTodo, value: Todo.listToJsonList(listTodo));
    isBusy = false;
  }
}
