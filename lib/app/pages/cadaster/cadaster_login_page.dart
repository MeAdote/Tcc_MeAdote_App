import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';

class LoginInfoPage extends StatefulWidget {
  final PageController pageController;
  
  const LoginInfoPage(this.pageController, {Key? key}) : super(key: key);

  @override
  State<LoginInfoPage> createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(''),
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: CadasterController.email,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Senha'),
            controller: CadasterController.password,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => {
                    widget.pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)
                  },
                  child: const Text('Voltar')),
              ElevatedButton(
                  onPressed: () => {
                    print(CadasterController.firstName.text)
                  },
                  child: const Text('Cadastrar'))
            ],
          )
        ],
      ),
    );
  }
}