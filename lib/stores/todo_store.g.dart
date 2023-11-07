// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on TodoStoreBase, Store {
  Computed<String?>? _$itemsDescriptionComputed;

  @override
  String? get itemsDescription => (_$itemsDescriptionComputed ??=
          Computed<String?>(() => super.itemsDescription,
              name: 'TodoStoreBase.itemsDescription'))
      .value;

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

  late final _$saveTodoAsyncAction =
      AsyncAction('TodoStoreBase.saveTodo', context: context);

  @override
  Future saveTodo(String text) {
    return _$saveTodoAsyncAction.run(() => super.saveTodo(text));
  }

  late final _$TodoStoreBaseActionController =
      ActionController(name: 'TodoStoreBase', context: context);

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
  dynamic deleteTodo(Todo todo) {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
        name: 'TodoStoreBase.deleteTodo');
    try {
      return super.deleteTodo(todo);
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listTodo: ${listTodo},
itemsDescription: ${itemsDescription}
    ''';
  }
}
