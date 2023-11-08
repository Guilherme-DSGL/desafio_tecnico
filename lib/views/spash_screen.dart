import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../core/components/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.authStore});
  final AuthStore authStore;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => widget.authStore.getCachedUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AppScaffold(
        body: ReactionBuilder(
          builder: (_) {
            return reaction((p0) => widget.authStore.isAuthenticated,
                (isAuthenticated) {
              if (isAuthenticated) {
                Navigator.pushNamed(context, "/todo");
              } else {
                Navigator.pushNamed(context, "/login");
              }
            });
          },
          child: const Column(
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
      ),
    ));
  }
}
