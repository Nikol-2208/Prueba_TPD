// To parse this JSON data, do
//
//     final task = taskFromMap(jsonString);

import 'dart:convert';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.ptsValue,
    required this.minsToNotification,
    required this.isHidden,
    required this.isCompleted,
    required this.createdDate,
    required this.dueDate,
    required this.completedDate,
    required this.idUser,
    required this.idDifficulty,
  });

  int id;
  String title;
  int ptsValue;
  int minsToNotification;
  bool isHidden;
  bool isCompleted;
  DateTime createdDate;
  DateTime dueDate;
  dynamic completedDate;
  int idUser;
  int idDifficulty;

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    ptsValue: json["ptsValue"],
    minsToNotification: json["minsToNotification"],
    isHidden: json["isHidden"],
    isCompleted: json["isCompleted"],
    createdDate: DateTime.parse(json["createdDate"]),
    dueDate: DateTime.parse(json["dueDate"]),
    completedDate: json["completedDate"],
    idUser: json["idUser"],
    idDifficulty: json["idDifficulty"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ptsValue": ptsValue,
    "minsToNotification": minsToNotification,
    "isHidden": isHidden,
    "isCompleted": isCompleted,
    "createdDate": createdDate.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "completedDate": completedDate,
    "idUser": idUser,
    "idDifficulty": idDifficulty,
  };
}
