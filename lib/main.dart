import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';
import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:desafio_tecnico/stores/todo_store.dart';
import 'package:desafio_tecnico/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/services/local_db_service/shared_prederence_service.dart';
import 'views/spash_screen.dart';
import 'views/todo/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

setup() async {
  GetIt getIt = GetIt.instance;
  final prefs = await SharedPreferencesService.initialize();
  getIt.registerSingleton<LocalDbService>(prefs);
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
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF2D958E)),
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              counterStyle: TextStyle(color: Colors.white),
              filled: true,
              border: OutlineInputBorder(),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF44BD6D)))),
        home: SplashScreen(authStore: GetIt.instance()),
        routes: {
          '/login': (context) => LoginScreen(authStore: GetIt.instance()),
          '/todo': (context) => TodoScreen(todoStore: GetIt.instance()),
        });
  }
}
