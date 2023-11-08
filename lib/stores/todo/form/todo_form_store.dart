import 'package:desafio_tecnico/stores/todo/form/todo_form_error_status.dart';
import 'package:mobx/mobx.dart';

import '../../../models/todo.dart';
part 'todo_form_store.g.dart';

class TodoFormStore = TodoFormStoreBase with _$TodoFormStore;

abstract class TodoFormStoreBase with Store {
  final TodoFormErrorStatus errors = TodoFormErrorStatus();

  late ReactionDisposer disposer;

  @observable
  String todoTitle = "";

  @observable
  Todo? selectedToEdit;

  @action
  setTodoTitle(String todoTitle) => this.todoTitle = todoTitle.trim();

  @action
  setSelectedToEdit(Todo todo) {
    setTodoTitle(todo.title);
    selectedToEdit = todo;
  }

  void setupValidations() {
    disposer = reaction((_) => todoTitle, validateTodoTitle);
  }

  void dispose() {
    disposer();
  }

  @action
  void resetForm() {
    setTodoTitle("");
    selectedToEdit = null;
  }

  @action
  void resetErrors() {
    errors.titleError = null;
  }

  @action
  void validateTodoTitle(String title) {
    if (title.isEmpty) {
      errors.titleError = "Digite um Texto";
      return;
    }
    errors.titleError = null;
  }

  void validateAll() {
    validateTodoTitle(todoTitle);
  }

  bool selectedToEditHasMatch(Todo todo) => todo == selectedToEdit;

  @computed
  bool get isSelectedTodo => selectedToEdit != null;

  @computed
  bool get isFormValid => !errors.hasErrors;
}
