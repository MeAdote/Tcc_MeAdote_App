import 'dart:io';
import 'package:flutter/material.dart';

class CadasterController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  File? profilePicture;

  CadasterController();

  // Singleton instance
  static final CadasterController _instance = CadasterController._internal();


  CadasterController._internal();

  void disposeAll() {
    firstName.dispose();
    lastName.dispose();
    age.dispose();
    telephone.dispose();
    postalCode.dispose();
    state.dispose();
    city.dispose();
    streetName.dispose();
    email.dispose();
    password.dispose();
    profilePicture = null;
  }
}
