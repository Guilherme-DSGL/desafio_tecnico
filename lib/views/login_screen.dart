import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../core/components/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required AuthStore authStore})
      : _authStore = authStore;

  final AuthStore _authStore;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

late TextEditingController _passwordEC;
late TextEditingController _userNameEC;
final _formKey = GlobalKey<FormState>();
bool obscurePassword = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _userNameEC = TextEditingController();
    _passwordEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordEC.dispose();
    _userNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: ReactionBuilder(
          builder: (context) {
            return reaction((_) => widget._authStore.user, (result) {
              if (widget._authStore.isAuthenticated()) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "todo", ModalRoute.withName('/'));
              }
            }, delay: 0);
          },
          child: Container(
            height: MediaQuery.sizeOf(context).height -
                MediaQuery.maybePaddingOf(context)!.top,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Usuário",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLength: 20,
                      controller: _userNameEC,
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        filled: true,
                        border: OutlineInputBorder(),
                        isCollapsed: false,
                        isDense: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[\s]'))
                      ],
                      validator: (f) {
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Senha",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 20,
                    controller: _passwordEC,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: obscurePassword
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined)),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'([a-zA-Z0-9])'))
                    ],
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return "É obrigatório";
                      }
                      if (pass.length <= 2) {
                        return "Muito curto";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 50,
                      width: 175,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF44BD6D)),
                        onPressed: () async {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;

                          if (formValid) {
                            await widget._authStore.authenticate(
                                _userNameEC.text, _passwordEC.text);
                          }
                        },
                        child: const Visibility(
                          visible: true,
                          replacement: CircularProgressIndicator(),
                          child: Text(
                            "Entrar",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
