// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoFormStore on TodoFormStoreBase, Store {
  Computed<bool>? _$isSelectedTodoComputed;

  @override
  bool get isSelectedTodo =>
      (_$isSelectedTodoComputed ??= Computed<bool>(() => super.isSelectedTodo,
              name: 'TodoFormStoreBase.isSelectedTodo'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: 'TodoFormStoreBase.isFormValid'))
          .value;

  late final _$todoTitleAtom =
      Atom(name: 'TodoFormStoreBase.todoTitle', context: context);

  @override
  String get todoTitle {
    _$todoTitleAtom.reportRead();
    return super.todoTitle;
  }

  @override
  set todoTitle(String value) {
    _$todoTitleAtom.reportWrite(value, super.todoTitle, () {
      super.todoTitle = value;
    });
  }

  late final _$selectedToEditAtom =
      Atom(name: 'TodoFormStoreBase.selectedToEdit', context: context);

  @override
  Todo? get selectedToEdit {
    _$selectedToEditAtom.reportRead();
    return super.selectedToEdit;
  }

  @override
  set selectedToEdit(Todo? value) {
    _$selectedToEditAtom.reportWrite(value, super.selectedToEdit, () {
      super.selectedToEdit = value;
    });
  }

  late final _$TodoFormStoreBaseActionController =
      ActionController(name: 'TodoFormStoreBase', context: context);

  @override
  dynamic setTodoTitle(String todoTitle) {
    final _$actionInfo = _$TodoFormStoreBaseActionController.startAction(
        name: 'TodoFormStoreBase.setTodoTitle');
    try {
      return super.setTodoTitle(todoTitle);
    } finally {
      _$TodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedToEdit(Todo todo) {
    final _$actionInfo = _$TodoFormStoreBaseActionController.startAction(
        name: 'TodoFormStoreBase.setSelectedToEdit');
    try {
      return super.setSelectedToEdit(todo);
    } finally {
      _$TodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$TodoFormStoreBaseActionController.startAction(
        name: 'TodoFormStoreBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$TodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrors() {
    final _$actionInfo = _$TodoFormStoreBaseActionController.startAction(
        name: 'TodoFormStoreBase.resetErrors');
    try {
      return super.resetErrors();
    } finally {
      _$TodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateTodoTitle(String title) {
    final _$actionInfo = _$TodoFormStoreBaseActionController.startAction(
        name: 'TodoFormStoreBase.validateTodoTitle');
    try {
      return super.validateTodoTitle(title);
    } finally {
      _$TodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todoTitle: ${todoTitle},
selectedToEdit: ${selectedToEdit},
isSelectedTodo: ${isSelectedTodo},
isFormValid: ${isFormValid}
    ''';
  }
}
