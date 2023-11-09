import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tcc_me_adote/app/models/pet_model.dart';

class PetRepository {
  Dio dio = Dio();
  final url = "https://192.168.15.2:7288/";
  
  Future<List<PetModel>> getPets() async {
    try {
      final response = await dio.get('${url}Pet');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final List<PetModel> pets = jsonList.map((json) => PetModel.fromJson(json)).toList();

        return pets;
      } else {
        throw Exception("Erro ao retornar pets");
      }
    } catch (e) {
      throw Exception("Erro ao buscar os pets: $e");
    }
  }

  Future<PetModel> getPetById(int id) async{
    try {
      final response = await dio.get('${url}Pet/$id');
      if(response.statusCode == 200){
      final Map<String, dynamic> jsonData = response.data;
      final pet = PetModel.fromJson(jsonData);

      return pet;
    }
    else{
      throw Exception('Erro ao retornar pet por ID');
    }
    } catch (e) {
      throw Exception('Erro ao retornar o pet por ID');
    }    
  }
}
