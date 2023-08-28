import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';

class Cadaster extends StatefulWidget {
  @override
  _Cadaster createState() => _Cadaster();
}

class _Cadaster extends State<Cadaster> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  DateTime? _selectedDate;
  late CreateUser createUser;

  static const titleName = [
    'Informações Pessoais',
    'Informações de Endereço',
    'Informações de Login'
  ];

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              buildPersonalInfoPage(),
              buildAddressInfoPage(),
              buildLoginInfoPage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPersonalInfoPage() {
    return Container(
        padding: EdgeInsets.all(50.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            Text(titleName[0]),
            const SizedBox(
              height: 100.0,
            ),
            Stack(
              children: [
                Container(
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
              controller:
                  TextEditingController(text: createUser.user?.firstName),
              onChanged: (value) => createUser.user?.firstName = value,
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Sobrenome'),
              controller:
                  TextEditingController(text: createUser.user?.lastName),
              onChanged: (value) => createUser.user?.lastName = value,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
                label: const Text('Data de nascimento')),
            if (_selectedDate != null)
              Text(
                  '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Telefone'),
              controller:
                  TextEditingController(text: createUser.user?.telephone),
              onChanged: (value) => createUser.user?.telephone = value,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    child: const Text('Próxima Página')))
          ]),
        ));
  }

  Widget buildAddressInfoPage() {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(titleName[1]),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'CEP'),
                  controller: TextEditingController(
                      text: createUser.userAdress?.postalCode),
                  onChanged: (value) =>
                      createUser.userAdress?.postalCode = value,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8)
                  ],
                ),
              ),
              const SizedBox(width: 10), // Espaço entre os elementos
              ElevatedButton(
                onPressed: () {
                  // Lógica para quando o botão for pressionado
                },
                child: const Text('Pesquisar Cep'),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Estado',
            ),
            controller:
                TextEditingController(text: createUser.userAdress?.state),
            onChanged: (value) => createUser.userAdress?.state = value,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Cidade'),
            controller: 
                TextEditingController(text: createUser.userAdress?.city),
          ),
          TextField(decoration: const InputDecoration(labelText: 'Rua'),
          controller: TextEditingController(text: createUser.userAdress?.streetName),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Text('Página Anterior')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () => _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Text('Próxima Página'))
            ],
          )
        ],
      ),
    );
  }

  Widget buildLoginInfoPage() {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(titleName[2]),
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: TextEditingController(text: createUser.userLogin?.email),
            onChanged: (value) => createUser.userLogin?.email = value,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Senha'),
            controller: TextEditingController(text: createUser.userLogin?.password),
            onChanged: (value) => createUser.userLogin?.password = value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  child: Text('Voltar')),
              ElevatedButton(onPressed: () => {}, child: Text('Cadastrar'))
            ],
          )
        ],
      ),
    );
  }
}
