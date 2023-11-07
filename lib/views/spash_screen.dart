import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/components/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() async {
      GetIt.I<AuthStore>().getCachedUser();
      if (GetIt.I<AuthStore>().isAuthenticated()) {
        Navigator.pushNamed(context, "/todo");
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: AppScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "To-Do",
              style: TextStyle(
                color: Colors.white,
                fontSize: 56,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
