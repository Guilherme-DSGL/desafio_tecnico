import 'package:flutter/material.dart';

class AppPrivacidade extends StatelessWidget {
  const AppPrivacidade({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Políticas de Privacidade",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
