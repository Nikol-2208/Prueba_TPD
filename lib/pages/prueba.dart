import 'package:flutter/material.dart';

import '../data/models/task.dart';
import '../data/services/Task_service.dart';

class MealsList extends StatefulWidget {
  @override
  _MealsListState createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void getTasks() async {
    print("fetching tasks");
    final response = await TaskService().getTasksList();
    setState(() {
      taskList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas"),
      ),
      body: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              final item = taskList[index];
              return GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 200,
                    ),
                    SizedBox(
                        height: 50,
                        child: Text(
                          item.title,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 28,
                              fontWeight: FontWeight.bold
                          ),
                        )),
                  ],
                ),
              );
            },
          )),
    );
  }
}
