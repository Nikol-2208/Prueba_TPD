// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';

import 'package:untitled1/Modelos/Modelo_User.dart';

class UserResponse {
  UserResponse({
    required this.message,
    required this.data,
    required this.warning,
  });

  dynamic message;
  User data;
  bool warning;

  factory UserResponse.fromJson(String str) => UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
    message: json["message"],
    data: User.fromMap(json["data"]),
    warning: json["warning"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data.toMap(),
    "warning": warning,
  };
}

