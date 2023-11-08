// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginFormStore on LoginFormStoreBase, Store {
  late final _$nameAtom =
      Atom(name: 'LoginFormStoreBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'LoginFormStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$obscurePasswordAtom =
      Atom(name: 'LoginFormStoreBase.obscurePassword', context: context);

  @override
  bool get obscurePassword {
    _$obscurePasswordAtom.reportRead();
    return super.obscurePassword;
  }

  @override
  set obscurePassword(bool value) {
    _$obscurePasswordAtom.reportWrite(value, super.obscurePassword, () {
      super.obscurePassword = value;
    });
  }

  late final _$LoginFormStoreBaseActionController =
      ActionController(name: 'LoginFormStoreBase', context: context);

  @override
  void changeObscurePassword() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
        name: 'LoginFormStoreBase.changeObscurePassword');
    try {
      return super.changeObscurePassword();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String name) {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
        name: 'LoginFormStoreBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
        name: 'LoginFormStoreBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String name) {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
        name: 'LoginFormStoreBase.validateName');
    try {
      return super.validateName(name);
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String password) {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
        name: 'LoginFormStoreBase.validatePassword');
    try {
      return super.validatePassword(password);
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
password: ${password},
obscurePassword: ${obscurePassword}
    ''';
  }
}
