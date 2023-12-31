import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_adress_page.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_login_page.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_user_page.dart';

class Cadaster extends StatefulWidget {
  @override
  _Cadaster createState() => _Cadaster();
}

class _Cadaster extends State<Cadaster> {
  @override
  void dispose() {
    _cadasterController.disposeAll();
    super.dispose();
  }

  final CadasterController _cadasterController = CadasterController();

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                
              });
            },
            children: [
              PersonalInfoPage(_pageController, _cadasterController),
              AdressInfoPage(_pageController, _cadasterController),
              LoginInfoPage(_pageController, _cadasterController),
            ],
          ),
        ],
      ),
    );
  }
}

