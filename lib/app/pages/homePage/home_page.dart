import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xfff5f5f5),
      actions: [
        IconButton(
          icon: Icon(Icons.account_balance_wallet),
        )
      ],
    );
  }
}
