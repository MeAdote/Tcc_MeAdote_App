import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_page.dart';
import 'package:tcc_me_adote/app/pages/login/login_page.dart';
import 'package:tcc_me_adote/app/pages/pets/list_pet_page.dart';
import 'package:tcc_me_adote/app/ui/theme/theme_config.dart';

class TccMeAdote extends StatelessWidget {
  const TccMeAdote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me Adote',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const PetListPage(),
        '/cadaster' :(context) => Cadaster(),
        '/pets': (context) => const PetListPage(),
        '/login' : (context) =>  LoginPage(),
      },
    );
  }
}
