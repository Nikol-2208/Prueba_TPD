import 'dart:convert';
import 'package:untitled1/Modelos/Modelo_User.dart';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(str);
String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.message,
    required this.data,
    required this.warning,
  });

  dynamic message;
  Data data;
  bool warning;

  factory UserLogin.fromJson(String str) => UserLogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLogin.fromMap(Map<String, dynamic> json) => UserLogin(
    message: json["message"],
    data: Data.fromMap(json["data"]),
    warning: json["warning"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data.toMap(),
    "warning": warning,
  };
}

class Data {
  Data({
    required this.token,
    required this.postulant,
  });

  String token;
  User postulant;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    token: json["token"],
    postulant: User.fromMap(json["postulant"]),
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "postulant": postulant.toMap(),
  };
}

