import 'package:get/get.dart';
import 'package:untitled1/data/models/task.dart';
import 'package:untitled1/data/repository/task_repository.dart';
import 'package:untitled1/helper/dbhelper.dart';


class TaskController extends GetxController{
  @override
  void onRead(){
    getTasks();
    super.onReady();
  }
  var taskList=<Task>[].obs;

  /*
  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }
  */

  void getTasks() async{
    List<Map<String,dynamic>> tasks=await DBHelper.query();
    /*taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());*/
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getTasks();
  }
}