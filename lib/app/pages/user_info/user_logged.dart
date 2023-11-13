import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/models/read_user_model.dart';
import 'package:tcc_me_adote/app/repositories/user_repository.dart';
import 'package:tcc_me_adote/app/ui/theme/theme_config.dart';

class UserLoggedInfo extends StatefulWidget {
  const UserLoggedInfo({Key? key}) : super(key: key);

  @override
  State<UserLoggedInfo> createState() => _UserLoggedInfoState();
}

class _UserLoggedInfoState extends State<UserLoggedInfo> {
  UserRepository repository = UserRepository();
  late Future<ReadUserModel> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = returnUser();
  }

  Future<ReadUserModel> returnUser() async {
    try {
      final user = await repository.getUserLogged();
      return user;
    } catch (e) {
      throw Exception('Erro ao retornar usuário');
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
            return const Text('Erro ao retornar os dados');
          } else {
            ReadUserModel user = snapshot.data!;
            // Faça algo com os dados do usuário aqui
            return Center(
              child: Column(
              children: [
                Image.network(user.userPicture!, width: 100,),
                Text('Olá ${user.firstName} ${user.lastName}'),


                const Text('Ver seus dados Cadastrais'),
                const Text('Cadastrar novo pet'),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sair '),
                      IconButton(onPressed:  () {}, icon: Icon(Icons.exit_to_app, color: Colors.red,)
                      ),
                    ],
                  )
                  
              ],
            ),
            );
            
          }
        },
      ),
    );
  }
}
