import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/pet_model.dart';
import 'package:tcc_me_adote/app/pages/user_info/user_info.dart';
import 'package:tcc_me_adote/app/repositories/pet_repository.dart';
import 'package:tcc_me_adote/app/ui/helpers/size_extensions.dart';
import 'package:tcc_me_adote/app/ui/theme/theme_config.dart';

class PetInfo extends StatefulWidget {
  const PetInfo({Key? key, required this.pet}) : super(key: key);

  final PetModel pet;

  @override
  State<PetInfo> createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  Future<PetModel>? petFuture;

  PetRepository repository = PetRepository();

  String? userId;

  @override
  void initState() {
    super.initState();
    petFuture = returnPet();
  }

  Future<PetModel> returnPet() async {
    try {
      final pet = await repository.getPetById(widget.pet.id!);
      return pet;    } catch (e) {
      throw Exception('Erro ao carregar dados do pet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeConfig.customAppBar,
      body: FutureBuilder<PetModel>(
        future: petFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {}
            final pet = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.screenWidth,
                  height: context.percentHeight(.4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(pet!.petPicture!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name!,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Idade: ${pet.age}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Raça: ${pet.race}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(pet.location!,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500))
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          userId = pet.idUser as String?;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserInfo(userid: pet.idUser)));
                          },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              pet.profilePicture!,
                              width: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${pet.firstName} ${pet.lastName}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sobre o pet:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        pet.description!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
