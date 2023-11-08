import 'package:desafio_tecnico/core/components/app_privacidade.dart';
import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:desafio_tecnico/stores/login/login_form_store.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  LoginFormStore loginFormStore = LoginFormStore();
  late ReactionDisposer disposer;
  @override
  void initState() {
    loginFormStore.setupValidations();
    super.initState();
  }

  @override
  void dispose() {
    loginFormStore.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer = reaction((_) => widget._authStore.isAuthenticated, (loggedIn) {
      Navigator.popAndPushNamed(context, "/todo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        reverse: false,
        child: ReactionBuilder(
          builder: (context) {
            return reaction((_) => widget._authStore.user, (result) {},
                delay: 0);
          },
          child: Container(
            height: MediaQuery.sizeOf(context).height -
                MediaQuery.maybePaddingOf(context)!.top,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
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
                  Observer(builder: (_) {
                    return TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: loginFormStore.setName,
                      readOnly: widget._authStore.isRequestPedding,
                      maxLength: 20,
                      decoration: InputDecoration(
                        errorText: loginFormStore.errorState.name,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    );
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
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: loginFormStore.setPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLength: 20,
                      readOnly: widget._authStore.isRequestPedding,
                      obscureText: loginFormStore.obscurePassword,
                      decoration: InputDecoration(
                        errorText: loginFormStore.errorState.password,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              loginFormStore.changeObscurePassword();
                            },
                            icon: loginFormStore.obscurePassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined)),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            loginFormStore.onlyCaracteresAndNumbers)
                      ],
                    );
                  }),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 50,
                      width: 175,
                      child: Observer(builder: (_) {
                        return ElevatedButton(
                          onPressed: () async {
                            loginFormStore.validateAll();
                            if (!loginFormStore.errorState.hasErrors) {
                              widget._authStore.authenticate(
                                  loginFormStore.name, loginFormStore.password);
                            }
                          },
                          child: Visibility(
                            visible: !widget._authStore.isRequestPedding,
                            replacement: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            child: const Text(
                              "Entrar",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  const AppPrivacidade()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
