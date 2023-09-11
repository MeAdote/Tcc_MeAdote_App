import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_adress_page.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_page.dart';

import '../../models/create_user.dart';

class PersonalInfoPage extends StatefulWidget {
  final PageController _controller;

  const PersonalInfoPage(this._controller, {Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            const Text('Informações Pessoais'),
            const SizedBox(
              height: 100.0,
            ),
            Stack(
              children: [
                Visibility(
                  visible: _pickedImage ==
                      null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue,
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
                // Imagem selecionada
                if (_pickedImage != null)
                  ClipOval(
                    child: Image.file(
                      _pickedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              controller: CadasterController.firstName,
            ),
            const SizedBox(height: 20.0),
            TextField(
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                controller: CadasterController.lastName),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Idade'),
              controller: CadasterController.birthDate,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Telefone'),
              controller: CadasterController.telephone,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => {
                          widget._controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease)
                        },
                    child: const Text('Próxima Página')))
          ]),
        ));
  }
}
