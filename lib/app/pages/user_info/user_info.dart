import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/read_user_model.dart';
import 'package:tcc_me_adote/app/repositories/user_repository.dart';
import 'package:tcc_me_adote/app/ui/theme/theme_config.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key, required this.userid}) : super(key: key);

  final int? userid;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Future<ReadUserModel>? userFuture;
  UserRepository repository = UserRepository();
  late String telefoneFormatado;

  @override
  void initState() {
    super.initState();
    userFuture = returnUser();
    telefoneFormatado = '';
  }

  Future<ReadUserModel> returnUser() async {
    try {
      final user = await repository.getUserById(widget.userid!);

      // Formata o número de telefone
      setState(() {
        telefoneFormatado = formatarTelefone(user.telephone!);
      });

      return user;
    } catch (e) {
      throw Exception('Erro ao retornar dados do usuário');
    }
  }

  String formatarTelefone(String telefone) {
    // Remove qualquer caracter não numérico
    String numeroLimpo = telefone.replaceAll(RegExp(r'[^\d]'), '');

    // Adiciona a máscara de telefone com base no comprimento
    if (numeroLimpo.length == 11) {
      return '(${numeroLimpo.substring(0, 2)}) ${numeroLimpo.substring(2, 7)}-${numeroLimpo.substring(7)}';
    } else if (numeroLimpo.length == 10) {
      return '(${numeroLimpo.substring(0, 2)}) ${numeroLimpo.substring(2, 6)}-${numeroLimpo.substring(6)}';
    } else {
      // Retorna o número sem formatação se não for possível formatar
      return telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeConfig.customAppBar,
      body: FutureBuilder<ReadUserModel>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao carregar dados do usuário');
          } else {
            ReadUserModel user = snapshot.data!;
            return Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Cor da borda
                          width: 2.0, // Largura da borda
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          user.userPicture!,
                          width: 80,
                          fit: BoxFit
                              .cover, // Ajuste a imagem para cobrir completamente o espaço disponível
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Telefone: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const Icon(Icons.local_phone_outlined),
                        Text(telefoneFormatado),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Email: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const Icon(Icons.email_outlined),
                        Text(user.email!)
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            'Postagens: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (user.petUsersDto != null &&
                        user.petUsersDto!.isNotEmpty)
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: user.petUsersDto!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var pet = user.petUsersDto![index];
                            return Column(children: [
                              Image.network(
                                pet.petPicture!,
                                width: 150,
                              ),
                              Text(pet.name!),
                            ]);
                          })
                    else
                      const Text('Usuário não possui postagens')
                  ]),
            );
          }
        },
      ),
    );
  }
}
