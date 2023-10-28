import 'dart:convert';

class AuthModel {
  final String token;

  AuthModel({required this.token});

  Map<String, dynamic> toMap(){
    return {
      'Token' : token
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map){
    return AuthModel(token: map['token']);
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
    AuthModel.fromMap(json.decode(source));
}
