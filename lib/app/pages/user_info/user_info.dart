import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/ui/theme/theme_config.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key, required this.userid});

  final int? userid;
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeConfig.customAppBar,
      body: const Column(
        children: [
           Text('Bem vindo a tela de doador {widget.userid}' )
          

        ],
      ),
    );
  }
}