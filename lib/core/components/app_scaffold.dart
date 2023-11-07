import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E4E62), Color(0xFF2D958E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
