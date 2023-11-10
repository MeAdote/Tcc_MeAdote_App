import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/pet_model.dart';
import 'package:tcc_me_adote/app/pages/pet_info/pet_info.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<PetModel> mockPetData = [
    PetModel(
      name: 'Pet 1',
      age: '2 anos',
      race: 'Raça 1',
      location: 'Localização 1',
      petPicture: 'https://firebasestorage.googleapis.com/v0/b/tccmeadote-d53b4.appspot.com/o/FotosPets%2FFotoCachorro1.jpeg?alt=media&token=56097a02-70bc-49e4-8677-cfed055108e3',
    ),
    PetModel(
      name: 'Pet 2',
      age: '1 ano',
      race: 'Raça 2',
      location: 'Localização 2',
      petPicture: 'https://firebasestorage.googleapis.com/v0/b/tccmeadote-d53b4.appspot.com/o/FotosPets%2FFotoGato2.jpeg?alt=media&token=733d7d81-5e02-4d32-a109-b228ad7699f2',
    ),
    // Adicione mais itens conforme necessário.
  ];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 47, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.person_2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Encontre seu\nPet em qualquer lugar',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF414141)),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Categoria Pets',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF414141)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF949494),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
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
                          const Text(
                            'Cachorros',
                            style: TextStyle(
                              color: Color(0xFF414141),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF949494),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
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
                          const Text(
                            'Gatos',
                            style: TextStyle(
                              color: Color(0xFF414141),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: mockPetData.length,
                      itemBuilder: (context, index) {
                        PetModel pets = mockPetData[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PetInfo(pet: pets)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
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
                                          color: Color(0xFF54D8FF),
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
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
