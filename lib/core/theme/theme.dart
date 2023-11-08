import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D958E)),
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      counterStyle: TextStyle(color: Colors.white),
      filled: true,
      border: OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF44BD6D),
      ),
    ),
  );
}
