import 'package:mobx/mobx.dart';

import '../models/todo.dart';
part 'todo_form_store.g.dart';

class TodoFormStore = TodoFormStoreBase with _$TodoFormStore;

abstract class TodoFormStoreBase with Store {
  @observable
  String? todoTitle;

  @observable
  Todo? selectedToEdit;

  @action
  setTodoTitle(String todoTitle) => this.todoTitle = todoTitle;
  @action
  setSelectedToEdit(Todo todo) {
    setTodoTitle(todo.title);
    selectedToEdit = todo;
  }

  String? validateTodoTitle(String? s) {
    if (isTodoTitleValid != null && !isTodoTitleValid!) {
      return "Digite um Texto";
    }
    return null;
  }

  @computed
  bool? get isTodoTitleValid => todoTitle?.isNotEmpty;

  @computed
  bool get isSelectTodo => selectedToEdit != null;

  @computed
  bool get isFormValid => isTodoTitleValid ?? false;
}
