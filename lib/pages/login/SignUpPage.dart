import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/pages/task/main_home.dart';

import '../../ui/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _nameTextController=TextEditingController();
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              textField("Enter Name", Icons.person_outline, false, _nameTextController),
              const SizedBox(height: 20,),
              textField("Enter Email", Icons.verified_user_rounded, false, _emailTextController),
              const SizedBox(height: 20,),
              textField("Enter Password", Icons.lock_outline, true, _passwordTextController),
              const SizedBox(height: 20,),
              LogInButton(context, false, (){
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                    password: _passwordTextController.text).then((value){
                    print("Created New Account");
                    Navigator.push(context
                    , MaterialPageRoute(builder: (context)=>HomePage()));
                }).onError((error, stackTrace){
                  print("Error ${error.toString()}");
                });
              })
            ],
          ),
        ),),
      ),
    );
  }
}


TextField textField(String text, IconData icon,bool isPasswordType, TextEditingController controller){
  return TextField(controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.grey,
    style: TextStyle(color:Colors.grey.withOpacity(0.9)),
    decoration: InputDecoration(prefixIcon: Icon(icon,color:Colors.grey),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor:Colors.grey.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))
    ),
    keyboardType: isPasswordType ? TextInputType.visiblePassword:TextInputType.emailAddress,
  );
}
Container LogInButton(BuildContext context,bool isLogin,Function onTap){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(onPressed: (){onTap();},
        child: Text(
          isLogin?'Log In':'Sign Up',
          style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Colors.white;
        }),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      )
  );
}
