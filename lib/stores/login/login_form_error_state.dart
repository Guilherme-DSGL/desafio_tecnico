import 'package:mobx/mobx.dart';
part 'login_form_error_state.g.dart';

class LoginFormErrorState = LoginFormErrorStateBase with _$LoginFormErrorState;

abstract class LoginFormErrorStateBase with Store {
  @observable
  String? password;

  @observable
  String? name;

  @computed
  bool get hasErrors => name != null || password != null;
}
