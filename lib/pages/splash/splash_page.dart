import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:untitled1/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState(){
    Timer(Duration(seconds: 8), openOnBoard);
    super.initState();
    controller=new AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation= new CurvedAnimation(parent: controller,
        curve: Curves.linear);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         ScaleTransition(scale: animation,
         child:Image.asset("images/Milestone_2.png", width: 250,) ,),
         Center(child:Image.asset("images/logo.png", width: 250,) ,)
        ],
      ),
    );
  }
  void openOnBoard()
  {
    Navigator.pushNamed(context, '_loginScreen');
  }
}
