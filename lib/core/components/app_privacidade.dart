import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          onPressed: () async {
            final url = Uri.parse(
                'https://www.google.com'); // Coloca a URL que desejas abrir
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          child: const Text(
            "Políticas de Privacidade",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
