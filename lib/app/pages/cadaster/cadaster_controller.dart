import 'dart:io';

import 'package:flutter/material.dart';

class CadasterController {
  static final TextEditingController firstName = TextEditingController();
  static final TextEditingController lastName = TextEditingController();
  static final TextEditingController age = TextEditingController();
  static final TextEditingController telephone = TextEditingController();

  static final TextEditingController postalCode = TextEditingController();
  static final TextEditingController state = TextEditingController();
  static final TextEditingController city = TextEditingController();
  static final TextEditingController streetName = TextEditingController();

  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();

  static File? profilePicture = null;

  // Use um construtor privado para evitar instâncias da classe

  CadasterController._();
  // Dispose de todos os controladores quando não forem mais necessários
  static void disposeAll() {
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
