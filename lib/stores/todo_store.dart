import 'package:desafio_tecnico/core/constants/keys.dart';
import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:mobx/mobx.dart';

import '../models/todo.dart';
part 'todo_store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  TodoStoreBase(this._localDbService);

  final LocalDbService _localDbService;
  @observable
  ObservableList<Todo> listTodo = ObservableList<Todo>();
  @computed
  String? get itemsDescription {
    if (listTodo.isEmpty) {
      return "There are no Todos here. Why don't you add one?.";
    }
    return null;
  }

  @action
  fetchTodoList() {
    final result = _localDbService.getListString(key: kTodo);
    if (result != null) {
      listTodo.addAll(Todo.listFromJsonList(result));
    }
  }

  @action
  saveTodo(String text) async {
    await _localDbService.insertListString(
        key: kTodo, value: Todo.listToJsonList(listTodo));
    listTodo.add(Todo(title: text));
  }

  @action
  deleteTodo(Todo todo) {}
}
