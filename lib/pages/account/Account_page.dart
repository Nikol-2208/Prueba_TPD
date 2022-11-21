import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../services/notifications_services.dart';
import '../../services/theme_services.dart';
import '../../ui/theme.dart';
import '../../ui/widgets/input_field_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _puntosController=TextEditingController();
  var notifyHelper;
  late final AnimationController controller;
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
      body: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile Account",
                  style:HeadingStyle,
                ),
                MyInputField2(title: "Name",hint: "Nicoll Malca", controller: _nameController),
                SizedBox(height: 18,),
                MyInputField2(title: "Email",hint: "nicoll@malca.pe", controller:_emailController),
                SizedBox(height: 18,),
                MyInputField2(title: "Points",hint: "1100 points", controller:_puntosController),
                SizedBox(height: 2,),
                Lottie.network("https://assets10.lottiefiles.com/packages/lf20_hilg7ehf.json")
              ],
            ),
          )
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

