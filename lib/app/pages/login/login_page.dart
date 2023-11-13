import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/auth_model.dart';
import 'package:tcc_me_adote/app/repositories/user_repository.dart';
import 'package:tcc_me_adote/app/utils/secure_storage_util.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/exceptions/unauthorized_exceptions.dart';
import '../../ui/styles/colors_app.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  SecureStorageUtil secureStorageUtil = SecureStorageUtil();
  UserRepository repository = UserRepository();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    try {
      AuthModel authModel = await repository.login(email, password);

      // Se o login for bem-sucedido, você pode armazenar o token ou realizar outras ações necessárias.
      secureStorageUtil.writeToken(authModel.token);

      Navigator.pushNamed(context, "/pets");
    } on UnauthorizedException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no Login: Credenciais inválidas')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha no Login: Verifique email e senha')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Faça seu Login',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                    validator: Validatorless.multiple([
                      Validatorless.email('Email Inválido'),
                      Validatorless.required('Email é Obrigatório')
                    ]),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    controller: _passwordController,
                    validator: Validatorless.multiple([
                      Validatorless.min(6, 'Senha não é menor que 6 caracteres'),
                      Validatorless.required('Senha é Obrigatória')
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorsApp.i.primary),
                        ),
                        onPressed: () async {
                          final valid = _formKey.currentState?.validate() ?? false;
                          if (valid) {
                            await login(_emailController.text, _passwordController.text);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
