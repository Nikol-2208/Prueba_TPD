import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/controllers/task_controller.dart';
import 'package:untitled1/ui/theme.dart';
import 'package:untitled1/ui/widgets/button.dart';
import 'package:untitled1/ui/widgets/input_field.dart';

import '../../data/models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController=Get.put(TaskController());

  final TextEditingController _titleController =TextEditingController();
  final TextEditingController _descriptionController =TextEditingController();

  DateTime _selectedDate=DateTime.now();
  String _endTime="9:30 PM";
  String _startTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind=10;
  List<int> remindList=[
    10,
    30,
    50,
    90
  ];
  String _selectedPriority="Facil";
  List<String> priorityList=[
    "Facil",
    "Medio",
    "Difícil",
  ];
  String _selectedRepeat= "None";
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  int _selectedColor=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:_appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Define tu Tarea",
                   style:HeadingStyle,
              ),
              MyInputField(title: "Title",hint: "Enter title here", controller: _titleController),
              MyInputField(title: "Description",hint: "Enter description here", controller:_descriptionController),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,
                  color:Colors.grey),
                  onPressed: (){
                    print("Hi There");
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(title: "Start Date", hint: _startTime,
                      widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey
                          ),
                        ),
                      )
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(title: "End Date", hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: Icon(
                              Icons.access_time_rounded,
                              color:Colors.grey
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
                        widget: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                            color:Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          style: subTitleStyle,
                          underline: Container(height: 0,),
                          onChanged: (String? newValue){
                            setState(() {
                              _selectedRemind=int.parse(newValue!);
                            });
                          },
                          items: remindList.map<DropdownMenuItem<String>>((int value){
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                        widget: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                            color:Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          style: subTitleStyle,
                          underline: Container(height: 0,),
                          onChanged: (String? newValue){
                            setState(() {
                              _selectedRepeat=newValue!;
                            });
                          },
                          items: repeatList.map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color:Colors.grey),),
                            );
                          }).toList(),
                        ),),
                  ),
                ],
              ),
              MyInputField(title: "Priority", hint: "$_selectedPriority",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color:Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedPriority=newValue!;
                    });
                  },
                  items: priorityList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTap: ()=>_validateDate())
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
     /* _addTasktoDB();*/
      Get.back();
    }
    else if(_titleController.text.isNotEmpty||_descriptionController.text.isNotEmpty){
      Get.snackbar("Required", "All fields are required",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      icon:Icon(Icons.warning_amber_rounded,
      color: Colors.red,));

    }
  }

  /*
  _addTasktoDB() async{
    int value = await _taskController.addTask(
        task:Task(
          description:_descriptionController.text,
          title:_titleController.text,
          date:DateFormat.yMd().format(_selectedDate),
          startTime:_startTime,
          endTime:_endTime,
          remind:_selectedRemind,
          repeat:_selectedRepeat,
          priority:_selectedPriority,
          color:_selectedColor,
          isCompleted:0,
        )
    );
    print("My id is "+"$value");
  }*/
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: titleStyle,),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(3,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor=index;
                      print("$index");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?tarea:index==1?event:reminder,
                      child: _selectedColor==index?Icon(Icons.done,
                          color: Colors.white,
                          size: 16):Container(),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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

  _getDateFromUser() async{
    DateTime? _pickerDate= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2122)
    );

    if(_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
        print(_selectedDate);
      });
    }else{
      print("It's null or something is wrong");
    }
  }

  _getTimeFromUser({ required bool isStartTime}) async {
    var pickedTime= await _showTimePicker();
    String _formatedTime=pickedTime.format(context);
    if(pickedTime==null){
      print("Time cancelled");
    }else if(isStartTime==true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])
        )
    );
  }

  _showAlertDialog(){
    return showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Add SubTask",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Padding(padding: EdgeInsets.only(
                top: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyButton(label: "Add", onTap: (){}),
                  SizedBox(width: 12,),
                  MyButton(label: "Save", onTap: (){})
                ],
              ))
            ]
          ),
        ));
  }

}
