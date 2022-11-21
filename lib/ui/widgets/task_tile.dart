import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/services/task_service.dart';
import 'package:untitled1/ui/theme.dart';

import 'package:untitled1/Modelos/Modelo_Task.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider=Provider.of<TaskProvider>(context);
    final Task _task =taskProvider.getTask(1);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.amber,
          ),
          child:Row(children: [
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _task.title,
                      style: GoogleFonts.lato(
                        textStyle:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${_task.createdDate} - ${_task.dueDate}",
                          style:GoogleFonts.lato(
                            textStyle:
                            TextStyle(fontSize:13,color:Colors.grey[100]),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
              margin:EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(quarterTurns: 3,
              child: Text(
                _task.isCompleted==1?"COMPLETED":"TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],)
      ),
    );
  }
}
