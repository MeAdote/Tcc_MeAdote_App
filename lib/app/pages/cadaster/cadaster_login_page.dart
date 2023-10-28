import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/repositories/firebase_repository.dart';
import 'package:tcc_me_adote/app/repositories/user_repository.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/styles/colors_app.dart';

class LoginInfoPage extends StatefulWidget {
  final PageController pageController;
  final CadasterController _cadasterController;

  const LoginInfoPage(this.pageController, this._cadasterController, {Key? key})
      : super(key: key);

  @override
  State<LoginInfoPage> createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  UserRepository repository = UserRepository();
  FireBaseRepository fireBaseRepository = FireBaseRepository();

  late List<String?> firebaseImage;

  //Imagem Referencia [0 - URL] [1 - Path]
  final List<String> imageReference = [];
  final storage = FirebaseStorage.instance;

  Future<void> cadasterUser() async {
    try {
      firebaseImage = await fireBaseRepository
          .uploadImageToFirebase(widget._cadasterController.profilePicture);
      await repository.register(firebaseImage[0], widget._cadasterController);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastrado com Sucesso')));
      Navigator.pushNamed(context, '/');
    } on DioException catch (e) {
      throw Exception(e.message);
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
                  children: [
                    const Text(
                      'Informação de Login',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      controller: widget._cadasterController.email,
                      validator: Validatorless.multiple([
                        Validatorless.required('Email é obrigatório'),
                        Validatorless.email('Digite um email válido')
                      ]),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      controller: widget._cadasterController.password,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha é obrigatório'),
                        Validatorless.min(
                            6, 'Campo deve ter no minimo 6 caracteres')
                      ]),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'Confirmar senha'),
                      validator: Validatorless.multiple([
                        Validatorless.required('Confirmar senha é obrigatório'),
                        Validatorless.compare(
                            widget._cadasterController.password,
                            'A senha deve ser igual')
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: _isLoading
                          ? const CircularProgressIndicator() // Ícone de carregamento
                          : ElevatedButton(
                              // Se não estiver carregando, mostre o botão
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorsApp.i.primary),
                              ),
                              onPressed: () async {
                                final valid =
                                    _formKey.currentState?.validate() ?? false;
                                if (valid) {
                                  setState(() {
                                    _isLoading = true; // Inicie o carregamento
                                  });
                                  try {
                                    await cadasterUser();
                                  } catch (e) {
                                    fireBaseRepository.deleteImageToFirebase(
                                      firebaseImage[1]!,
                                    );
                                  } finally {
                                    setState(() {
                                      _isLoading =
                                          false; // Termine o carregamento
                                    });
                                  }
                                }
                              },
                              child: const Text('Cadastrar'),
                            ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
