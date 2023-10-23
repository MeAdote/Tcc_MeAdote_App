import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/styles/colors_app.dart';

class AdressInfoPage extends StatefulWidget {
  final PageController pageController;
  final CadasterController _textFieldController;

  const AdressInfoPage(this.pageController, this._textFieldController, {Key? key}) : super(key: key);

  @override
  State<AdressInfoPage> createState() => _AdressInfoPageState();
}

class _AdressInfoPageState extends State<AdressInfoPage> {
  final _formKey = GlobalKey<FormState>();
  
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
                  const Text('Informações de Endereço',
                  style: TextStyle(
                    fontSize: 25.0
                  ),),
                  const SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'CEP'),
                    controller: widget._textFieldController.postalCode,
                    validator: Validatorless.multiple([
                      Validatorless.required('CEP é obrigatório'),
                      Validatorless.max(
                          8, 'CEP deve conter no maximo 8 caracteres'),
                      Validatorless.min(
                          8, 'CEP deve conter no minimo 8 caracteres')
                    ]),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                    ),
                    controller: widget._textFieldController.state,
                    validator: Validatorless.required('Estado é obrigatório'),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Cidade'),
                    controller: widget._textFieldController.city,
                    validator: Validatorless.required('Cidade é obrigatório'),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Rua'),
                    controller: widget._textFieldController.streetName,
                    validator: Validatorless.required('Rua é Obrigatório'),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Center(
                      child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsApp.i.primary),
                      ),
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: const Text('Próxima Página'),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
