import 'package:flutter/material.dart';

import '../../models/pet_model.dart';
import '../../repositories/pet_repository.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  final PetRepository repository = PetRepository();
  List<PetModel>? petData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await repository.getPets();
      setState(() {
        petData = data.cast<PetModel>();
      });
    } catch (e) {
      // Alterei 'E' para 'e'
      print("Erro ao buscar os pets: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 47, 20, 0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinhe o conteúdo à esquerda
          children: [
            Align(
              alignment: Alignment
                  .topRight, // Alinhe o botão no canto superior direito
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.person_2,
                    color: Colors.white, // Defina a cor do ícone como branca
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Encontre seu\nPet em qualquer lugar',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Categoria Pets',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Cor da borda (preta)
                      width: 2.0, // Espessura da borda
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // Curvatura da borda
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/dogface.png',
                            width: 35,
                            height: 35,
                          ),
                          const Text('Cachorros'),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                width: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 35, 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/catface.png',
                            width: 35,
                            height: 35,
                          ),
                          const Text('Gatos'),
                        ],
                      ),
                    ),
                  )),
            ]),
            Expanded(
              child: ListView.builder(
                itemCount: petData?.length ?? 0,
                itemBuilder: (context, index) {
                  PetModel pets = petData![index];
                  return Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white), // Cor da borda
                          borderRadius:
                              BorderRadius.circular(10.0), // Curvatura da borda
                          color: Colors.white // Cor de fundo
                          ),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                pets.petPicture!,
                                width: 150,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pets.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Idade: ${pets.age!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Raça: ${pets.race!}'),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                    ),
                                    Text(
                                      pets.location!,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
