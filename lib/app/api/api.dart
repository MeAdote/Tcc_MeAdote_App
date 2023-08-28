import 'package:dio/dio.dart';
import 'package:tcc_me_adote/app/models/create_user.dart';

class Api{
  String url = "";
  void cadaster(CreateUser user) async
  {
    Dio dio = Dio();
    await dio.post<CreateUser>("URL", data: user.toJson());
  }
}