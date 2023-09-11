import 'package:flutter/material.dart';

class CadasterController {
  static final TextEditingController firstName = TextEditingController();
  static final TextEditingController lastName = TextEditingController();
  static final TextEditingController birthDate = TextEditingController();
  static final TextEditingController telephone = TextEditingController();

  static final TextEditingController postalCode = TextEditingController();
  static final TextEditingController state = TextEditingController();
  static final TextEditingController city = TextEditingController();
  static final TextEditingController streetName = TextEditingController();

  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();

  // Use um construtor privado para evitar instâncias da classe

  CadasterController._();
  // Dispose de todos os controladores quando não forem mais necessários
  static void disposeAll() {
    firstName.dispose();
    lastName.dispose();
    birthDate.dispose();
    telephone.dispose();
    postalCode.dispose();
  }
}
