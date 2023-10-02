import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/repositories/user_repository.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/styles/colors_app.dart';

class LoginInfoPage extends StatefulWidget {
  final PageController pageController;

  const LoginInfoPage(this.pageController, {Key? key}) : super(key: key);

  @override
  State<LoginInfoPage> createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> CadasterUser() async {
    UserRepository _repository = UserRepository();

    var urlImage =
        await uploadImageToFirebase(CadasterController.profilePicture);
    _repository.userCadaster(urlImage);
  }

  Future<String?> uploadImageToFirebase(File? imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final imageName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Nome único para a imagem
      final Reference storageReference =
          storage.ref().child('FotosUsuarios/$imageName.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile!);

      // Aguarde o término do upload
      await uploadTask.whenComplete(() => null);

      // Recupere a URL da imagem no Firebase Storage
      final imageUrl = await storageReference.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw new Exception('');
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
                      controller: CadasterController.email,
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
                      controller: CadasterController.password,
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
                        Validatorless.compare(CadasterController.password,
                            'A senha deve ser igual')
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorsApp.i.primary),
                        ),
                        onPressed: () {
                          final valid =
                              _formKey.currentState?.validate() ?? false;
                          if (valid) {
                            CadasterUser();
                          }
                        },
                        child: const Text('Próxima Página'),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
