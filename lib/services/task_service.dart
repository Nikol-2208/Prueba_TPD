import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:untitled1/Modelos/Modelo_Task.dart';

class TaskProvider with ChangeNotifier{
  String urlApi="https://mc-server-gestion.herokuapp.com/users/2/tasks";
  getTask(int id) async{
    var url=Uri.https("mc-server-gestion.herokuapp.com","/users/${id}/tasks");
    final response=await https.get(url);
    final task=Task.fromJson(response.body);
    notifyListeners();
    return task;
  }
}