import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:tcc_me_adote/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:tcc_me_adote/app/models/auth_model.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';
import 'package:tcc_me_adote/app/models/read_user_model.dart';
import 'package:tcc_me_adote/app/pages/cadaster/cadaster_controller.dart';

import '../utils/secure_storage_util.dart';

class UserRepository {
  final String url = "https://192.168.15.2:7288/User";
  Dio dio = Dio();
  Future<void> register(
      String? imageUrl, CadasterController textController) async {
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
    try {
      await dio.post("$url/cadaster", data: user.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('Email já cadastrado');
      }
    }
  }

  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.post('$url/Authenticate',
          data: {'email': email, 'password': password});
      return AuthModel.fromMap(result.data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        throw UnauthorizedException();
      }
      throw Exception('Erro ao realizar login');
    }
  }

  Future<ReadUserModel> getUserById(int idUser) async {
    try {
      final String? token = await SecureStorageUtil().readToken('token');
      final Response response = await dio.get('$url/userpet/$idUser',
      options: Options(headers: {'Authorization' : 'Bearer $token'}));

      if (response.statusCode == 200) {

        Map<String, dynamic> jsonData = json.decode(response.toString());

        ReadUserModel readUser = ReadUserModel.fromJson(jsonData);

        return readUser;
      } else {
        throw Exception('Falha ao obter usuário');
        
      }
    } catch (error) {
      print('Erro ao obter usuário: $error');
      throw Exception('Erro ao obter usuário');
    }
  }



  Future<ReadUserModel> getUserLogged() async{
    try {
      final String? token = await SecureStorageUtil().readToken('token');
      final Response response = await dio.get('$url/userLogged',
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
      if(response.statusCode == 200){
        Map<String, dynamic> jsonData = json.decode(response.toString());

        ReadUserModel readUser = ReadUserModel.fromJson(jsonData);
        return readUser;
      }

      else{
        throw Exception('Erro ao retornar usuário');
      }

    } catch (e) {
      throw Exception('Erro ao retornar usuário');
    }
  }
}
