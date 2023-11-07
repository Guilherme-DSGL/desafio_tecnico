import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:get_it/get_it.dart';

class AuthGuard {
  AuthGuard._();

  canActivate() {
    if (GetIt.I<AuthStore>().isAuthenticated()) {}
  }
}
