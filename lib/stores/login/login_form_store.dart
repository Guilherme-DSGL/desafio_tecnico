import 'package:desafio_tecnico/stores/login/login_form_error_state.dart';
import 'package:mobx/mobx.dart';
part 'login_form_store.g.dart';

class LoginFormStore = LoginFormStoreBase with _$LoginFormStore;

abstract class LoginFormStoreBase with Store {
  final errorState = LoginFormErrorState();

  final allowCaracteresAndNumbers = RegExp(r'[a-zA-Z0-9]');

  final dennySpecialCaracteres = RegExp(r'^[a-zA-Z0-9]+$');

  @observable
  String name = '';

  @observable
  String password = '';

  @observable
  bool obscurePassword = true;

  @action
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  @action
  void setName(String name) => this.name = name.trim();

  @action
  void setPassword(String password) => this.password = password.trim();

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => password, validatePassword)
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @action
  void validateName(String name) {
    if (name.isEmpty) {
      errorState.name = "O nome não pode estar vazio";
      return;
    }

    if (name.length > 20) {
      errorState.name = "O nome não pode ser maior que 20 caracteres";
      return;
    }
    errorState.name = null;
  }

  @action
  void validatePassword(String password) {
    if (password.isEmpty) {
      errorState.password = "A senha não pode estar vazia";
      return;
    }
    if (password.length > 20) {
      errorState.password = "A senha não pode ser maior que 20 caracteres";
      return;
    }
    if (!dennySpecialCaracteres.hasMatch(password)) {
      errorState.password = "A senha não pode conter caracteres especiais";
      return;
    }
    errorState.password = null;
  }

  void validateAll() {
    validatePassword(password);
    validateName(name);
  }
}
