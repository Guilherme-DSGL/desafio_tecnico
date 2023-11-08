import 'package:desafio_tecnico/core/components/app_privacidade.dart';
import 'package:desafio_tecnico/stores/auth_store.dart';
import 'package:desafio_tecnico/stores/login/login_form_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../core/components/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(
      {super.key,
      required AuthStore authStore,
      required LoginFormStore loginFormStore})
      : _loginFormStore = loginFormStore,
        _authStore = authStore;

  final AuthStore _authStore;
  final LoginFormStore _loginFormStore;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ReactionDisposer disposer;
  @override
  void initState() {
    widget._loginFormStore.setupValidations();
    super.initState();
  }

  @override
  void dispose() {
    widget._loginFormStore.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer = reaction((_) => widget._authStore.isAuthenticated, (loggedIn) {
      Navigator.popAndPushNamed(context, "/todo");
    });
  }

  _submit() {
    widget._loginFormStore.validateAll();
    if (!widget._loginFormStore.errorState.hasErrors) {
      widget._authStore.authenticate(
          widget._loginFormStore.name, widget._loginFormStore.password);
    }
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
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: widget._loginFormStore.setName,
                      readOnly: widget._authStore.isRequestPedding,
                      maxLength: 20,
                      decoration: InputDecoration(
                        errorText: widget._loginFormStore.errorState.name,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      onFieldSubmitted: (e) {
                        widget._loginFormStore
                            .validateName(widget._loginFormStore.name);
                      },
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
                      textInputAction: TextInputAction.done,
                      onChanged: widget._loginFormStore.setPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLength: 20,
                      readOnly: widget._authStore.isRequestPedding,
                      obscureText: widget._loginFormStore.obscurePassword,
                      decoration: InputDecoration(
                        errorText: widget._loginFormStore.errorState.password,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              widget._loginFormStore.changeObscurePassword();
                            },
                            icon: widget._loginFormStore.obscurePassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined)),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            widget._loginFormStore.allowCaracteresAndNumbers)
                      ],
                      onFieldSubmitted: (e) {
                        _submit();
                      },
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
                          onPressed: () {
                            _submit();
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
