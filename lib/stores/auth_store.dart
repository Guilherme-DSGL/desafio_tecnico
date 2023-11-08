import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:mobx/mobx.dart';

import '../core/constants/keys.dart';
import '../models/user.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalDbService _localDbService;

  AuthStoreBase(this._localDbService);
  @observable
  ObservableFuture<User>? _user;

  ObservableFuture<User>? get user {
    return _user;
  }

  bool get isAuthenticated => _user?.value != null;

  bool get isRequestPedding => _user?.status == FutureStatus.pending;

  @action
  ObservableFuture<User> authenticate(String userName, String password) =>
      _user = ObservableFuture(_authenticate(userName, password));

  Future<User> _authenticate(String userName, String password) async {
    final result =
        await ApiMock.authenticate(userName: userName, password: password);
    await _cacheUser(user: result);
    return result;
  }

  Future<void> _cacheUser({required User user}) async {
    await _localDbService.insert(key: kUserAuth, value: user.toJson());
  }

  getCachedUser() {
    final userJson = _localDbService.get(key: kUserAuth);
    if (userJson != null) {
      _user = ObservableFuture.value(User.fromJson(userJson));
    }
  }
}

class ApiMock {
  static Future<User> authenticate(
      {required String userName, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    return User(userName: userName);
  }
}
