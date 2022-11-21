import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../data/models/task.dart';
import '../../services/notifications_services.dart';
import '../../services/theme_services.dart';
import '../../ui/theme.dart';
import '../../ui/widgets/button.dart';
import '../../ui/widgets/task_tile.dart';
import 'add_task_bar.dart';

class DailyTask extends StatefulWidget {
  const DailyTask({Key? key}) : super(key: key);

  @override
  State<DailyTask> createState() => _DailyTaskState();
}

class _DailyTaskState extends State<DailyTask> {
  final TaskController _taskController=Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          SizedBox(height: 10,),
          /*_showTasks(),*/
        ],
      ),
    );
  }

  /*
  _showTasks(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_,index) {
              Task task=_taskController.taskList[index];
              /*print(task.toJson());*/
              if(task.repeat=='Daily'){
                DateTime date=DateFormat.jm().parse(task.startTime.toString());
                var myTime=DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child: TaskTile(task),
                                  )
                                ]
                            )
                        )
                    ));
              }
              if(task.date==DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child: TaskTile(task),
                                  )
                                ]
                            )
                        )
                    ));
              }else{
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top:4),
          height: task.isCompleted==1?
          MediaQuery.of(context).size.height*0.24:
          MediaQuery.of(context).size.height*0.32,
          color: Get.isDarkMode?darkGreyClr:Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
                ),
              ),
              Spacer(),
              task.isCompleted==1?
              Container()
                  : _bottomSheetButton(
                  label: "Task completed",
                  onTap: (){
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context:context
              ),
              _bottomSheetButton(
                  label: "Delete Task",
                  onTap: (){
                    _taskController.delete(task);
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context:context
              ),
              SizedBox(
                height: 20,
              ),
              _bottomSheetButton(
                  label: "Close",
                  onTap: (){
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context:context
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )
      ),
    );
  }
*/
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context,
  }){
    return GestureDetector(
        onTap:onTap,
        child:Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color:isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color:isClose==true?Colors.transparent:clr,
          ),
          child: Center(
            child: Text(
              label,
              style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white),
            ),
          ),
        )
    );
  }


  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                    style: HeadingStyle
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title:"Theme Changed",
              body:Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
          );

          notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode ?Icons.wb_sunny_rounded:Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode? Colors.white:Colors.black,),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/photo.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
