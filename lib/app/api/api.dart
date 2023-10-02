import 'package:dio/dio.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';

class Api{
  String url = "https://192.168.15.2:7288";
  Future<String> cadasterApi(CreateUser user) async {
  Dio dio = Dio();
  try {
    Response response = await dio.post("$url/User/cadaster", data: user.toJson());
    if (response.statusCode == 200) {
      // Se o código de status for 200, a resposta é bem-sucedida e você pode converter para CreateUser.
      CreateUser createdUser = CreateUser.fromJson(response.data);
      return "Cadastrado com Sucesso";
    } else {
      // Lidar com outros códigos de status ou erros aqui.
      return "Erro na requisição";
    }
  } catch (e) {
    // Lidar com exceções aqui.
    return "Erro na requisição";
  }
}

}