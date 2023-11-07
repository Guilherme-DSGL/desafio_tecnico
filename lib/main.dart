import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:desafio_tecnico/stores/todo_store.dart';
import 'package:desafio_tecnico/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/services/local_db_service/shared_prederence_service.dart';
import 'views/spash_screen.dart';
import 'views/todo_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

setup() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingletonAsync<LocalDbService>(
      () async => await SharedPreferencesService.initialize());
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(getIt()));
  getIt.registerLazySingleton<TodoStore>(() => TodoStore(getIt()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D958E)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => LoginScreen(authStore: GetIt.instance()),
          '/todo': (context) => TodoScreen(todoStore: GetIt.instance()),
        });
  }
}
