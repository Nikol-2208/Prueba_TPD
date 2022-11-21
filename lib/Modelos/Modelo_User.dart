// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.score,
    required this.passwordHash,
    required this.passwordSalt,
  });

  String firstName;
  String lastName;
  String email;
  String score;
  String passwordHash;
  String passwordSalt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    score: json["score"],
    passwordHash: json["passwordHash"],
    passwordSalt: json["passwordSalt"],
  );

  Map<String, dynamic> toMap() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "score": score,
    "passwordHash": passwordHash,
    "passwordSalt": passwordSalt,
  };
}
