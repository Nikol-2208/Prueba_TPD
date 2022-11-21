import 'dart:convert';
import 'package:untitled1/data/models/task.dart';
import 'package:http/http.dart';


class TaskService {
  List<Task> taskList = [];

  Future<List<Task>> getTasksList() async {
    Response taskResponse = await get(Uri.parse(
        'https://mc-server-gestion.herokuapp.com/users/2/tasks'));
    Map data = jsonDecode(utf8.decode(taskResponse.bodyBytes));
    final categoriesResults = data['todo'];
    for (var i = 0; i < categoriesResults.length; i++) {
      Task task = Task(
         id:categoriesResults[i]['id'],
         title:categoriesResults[i]['title'],
         minsToNotification: categoriesResults[i]['minsToNotification'],
         isHidden:categoriesResults[i]['isHidden'],
         isCompleted:categoriesResults[i]['isCompleted'],
         createdDate:categoriesResults[i]['createdDate'],
         dueDate:categoriesResults[i]['dueDate'],
         completedDate:categoriesResults[i]['completedDate']);
      taskList.add(task);
    }
    return taskList;
  }
}