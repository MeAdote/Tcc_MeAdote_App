import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_page.dart';
import 'package:tcc_me_adote/app/ui/styles/colors_app.dart';
import 'package:validatorless/validatorless.dart';
class PersonalInfoPage extends StatefulWidget {
  final PageController _controller;
  final CadasterController _textFieldController;


  const PersonalInfoPage(this._controller, this._textFieldController, {Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();

  

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        widget._textFieldController.profilePicture = File(result.files.single.path!);
      });
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
                  const Text(
                    'Informações Pessoais',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Stack(
                    children: [
                      Visibility(
                        visible: widget._textFieldController.profilePicture == null,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: ColorsApp.i.primary,
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () => _pickImage(),
                            icon: const Icon(Icons.person),
                            label: const Text('Selecione sua foto'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget._textFieldController.profilePicture != null)
                        Column(
                          children: [
                            ClipOval(
                              child: Image.file(
                                widget._textFieldController.profilePicture!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () => {
                                  _pickImage()
                                },
                                child: const Text('Trocar foto'))
                          ],
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: widget._textFieldController.firstName,
                    validator: Validatorless.multiple(
                        [Validatorless.required('Nome obrigatório')]),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(labelText: 'Sobrenome'),
                      controller: widget._textFieldController.lastName,
                      validator: Validatorless.multiple([
                        Validatorless.required('Sobrenome obrigatório')
                      ]),
                      ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Idade'),
                    controller: widget._textFieldController.age,
                    keyboardType: TextInputType.number,
                    validator: Validatorless.required('Idade é obrigatório'),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    keyboardType: TextInputType.number,
                    validator: Validatorless.multiple([
                      Validatorless.required('Telefone é Obrigatório'),
                      Validatorless.min(10, "Número de telefone inválido")
                    ]),
                    controller: widget._textFieldController.telephone,
                  ),
                  const SizedBox(height: 40.0,),
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
                            widget._controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: const Text('Próxima Página'),
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
