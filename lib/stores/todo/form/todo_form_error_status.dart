import 'package:mobx/mobx.dart';
part 'todo_form_error_status.g.dart';

class TodoFormErrorStatus = TodoFormErrorStatusBase with _$TodoFormErrorStatus;

abstract class TodoFormErrorStatusBase with Store {
  @observable
  String? titleError;

  @computed
  bool get hasErrors => titleError != null;
}
