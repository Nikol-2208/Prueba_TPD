import 'package:get/get.dart';
import 'package:untitled1/data/api/api_client.dart';

class TaskRepository extends GetxService{
  final ApiClient apiClient;
  TaskRepository({required this.apiClient});

  Future<Response> getTask() async{
    return await apiClient.getData("end point url");


  }
}