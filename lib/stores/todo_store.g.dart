// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on TodoStoreBase, Store {
  late final _$isBusyAtom =
      Atom(name: 'TodoStoreBase.isBusy', context: context);

  @override
  bool get isBusy {
    _$isBusyAtom.reportRead();
    return super.isBusy;
  }

  @override
  set isBusy(bool value) {
    _$isBusyAtom.reportWrite(value, super.isBusy, () {
      super.isBusy = value;
    });
  }

  late final _$listTodoAtom =
      Atom(name: 'TodoStoreBase.listTodo', context: context);

  @override
  ObservableList<Todo> get listTodo {
    _$listTodoAtom.reportRead();
    return super.listTodo;
  }

  @override
  set listTodo(ObservableList<Todo> value) {
    _$listTodoAtom.reportWrite(value, super.listTodo, () {
      super.listTodo = value;
    });
  }

  late final _$editTodoAsyncAction =
      AsyncAction('TodoStoreBase.editTodo', context: context);

  @override
  Future editTodo() {
    return _$editTodoAsyncAction.run(() => super.editTodo());
  }

  late final _$saveTodoAsyncAction =
      AsyncAction('TodoStoreBase.saveTodo', context: context);

  @override
  Future saveTodo(String text) {
    return _$saveTodoAsyncAction.run(() => super.saveTodo(text));
  }

  late final _$deleteTodoAsyncAction =
      AsyncAction('TodoStoreBase.deleteTodo', context: context);

  @override
  Future deleteTodo(Todo todo) {
    return _$deleteTodoAsyncAction.run(() => super.deleteTodo(todo));
  }

  late final _$TodoStoreBaseActionController =
      ActionController(name: 'TodoStoreBase', context: context);

  @override
  dynamic submitForm() {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
        name: 'TodoStoreBase.submitForm');
    try {
      return super.submitForm();
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fetchTodoList() {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
        name: 'TodoStoreBase.fetchTodoList');
    try {
      return super.fetchTodoList();
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isBusy: ${isBusy},
listTodo: ${listTodo}
    ''';
  }
}
