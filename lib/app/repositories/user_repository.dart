import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';
import 'package:tcc_me_adote/app/api/api.dart';

class UserRepository {
  
  Future<String> userCadaster(String? imageUrl) async
  {
    CreateUser createUser = CreateUser(
      user: User(
        firstName: CadasterController.firstName.text,
        lastName: CadasterController.lastName.text,
        age: int.parse(CadasterController.age.text),
        telephone: CadasterController.telephone.text,
        profilePicture: imageUrl,
        ),
        userAdress: UserAdress(
          streetName: CadasterController.streetName.text,
          city: CadasterController.city.text,
          state: CadasterController.state.text,
          postalCode: CadasterController.postalCode.text,
        ),
        userLogin: UserLogin(
          email: CadasterController.email.text,
          password: CadasterController.password.text
        )
    );
    Api api = Api();
    api.cadasterApi(createUser);
    return "Usuário Cadastrado";
  }
}