// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_form_error_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoFormErrorStatus on TodoFormErrorStatusBase, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: 'TodoFormErrorStatusBase.hasErrors'))
          .value;

  late final _$titleErrorAtom =
      Atom(name: 'TodoFormErrorStatusBase.titleError', context: context);

  @override
  String? get titleError {
    _$titleErrorAtom.reportRead();
    return super.titleError;
  }

  @override
  set titleError(String? value) {
    _$titleErrorAtom.reportWrite(value, super.titleError, () {
      super.titleError = value;
    });
  }

  @override
  String toString() {
    return '''
titleError: ${titleError},
hasErrors: ${hasErrors}
    ''';
  }
}
