import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:tcc_me_adote/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:tcc_me_adote/app/models/auth_model.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';

class UserRepository {
  final String url = "https://localhost:5001";
  Dio dio = Dio();
  Future<void> register(String? imageUrl, CadasterController textController) async {

    CreateUser user = CreateUser(
        user: User(
          firstName: textController.firstName.text,
          lastName: textController.lastName.text,
          age: int.parse(textController.age.text),
          telephone: textController.telephone.text,
          profilePicture: imageUrl,
        ),
        userAdress: UserAdress(
          streetName: textController.streetName.text,
          city: textController.city.text,
          state: textController.state.text,
          postalCode: textController.postalCode.text,
        ),
        userLogin: UserLogin(
            email: textController.email.text,
            password: textController.password.text));
    try{
      await dio.post("$url/User/cadaster", data: user.toJson());
    }
     on DioException catch(e){
      if(e.response?.statusCode == 409){
        throw Exception('Email já cadastrado');
      }
    }
  }
  Future<AuthModel> login(String email, String password) async{
    try {
      final result = await dio.post(url + '/User/Authenticate', data: {
        'email' : email,
        'password': password
      });
      return AuthModel.fromMap(result.data);
    } on DioException catch (e, s) { 
      if(e.response?.statusCode == 403){
        throw UnauthorizedException();
      }
      throw Exception('Erro ao realizar login');
    }
  }
}
