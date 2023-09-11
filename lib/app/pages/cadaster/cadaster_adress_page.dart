import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';

class AdressInfoPage extends StatefulWidget {
  final PageController pageController;

  const AdressInfoPage(this.pageController,{Key? key}) : super(key: key);

  @override
  State<AdressInfoPage> createState() => _AdressInfoPageState();
}

class _AdressInfoPageState extends State<AdressInfoPage> {

  final TextEditingController _ = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Informações de Endereço'),
          Row(
            children: [
               Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'CEP'),
                  controller: CadasterController.postalCode,
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
            controller: CadasterController.state,
          ),
           TextField(
            decoration: const InputDecoration(labelText: 'Cidade'),
            controller: CadasterController.city,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Rua'),
            controller: CadasterController.streetName,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => {
                    widget.pageController.previousPage(duration: const Duration(microseconds: 300), curve: Curves.ease)
                  }, child: const Text('Página Anterior')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () => {
                    widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)
                  }, child: const Text('Próxima Página'))
            ],
          )
        ],
      ),
    );
    ;
  }
}
