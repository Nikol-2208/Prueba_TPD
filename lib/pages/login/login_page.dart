import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../services/user_service.dart';


class LoginPostulant extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Logo(),

                  _Form(),

                  Labels(
                    ruta: 'register_screen',
                    titulo: '¿No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),

                  Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)

                ],
              ),
            ),
          ),
        )
    );
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<UserServiceProvider>( context );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),


          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando ? ()=>{} : () async {

                FocusScope.of(context).unfocus();
                final loginOK = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                if (loginOK)
                {
                  Navigator.pushReplacementNamed(context, 'home_screen');
                }
              }
          )
        ],
      ),
    );
  }
}

class BotonAzul extends StatelessWidget {

  final String text;
  final Function onPressed;

  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(2),
          shape: MaterialStateProperty.all(StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.indigo)
      ),
      // elevation: 2,
      // highlightElevation: 5,
      // color: Colors.blue,
      // shape: StadiumBorder(),
      onPressed: () => this.onPressed(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
        ),
      ),
    );
  }

}

class Labels extends StatelessWidget {

  final String ruta;
  final String titulo;
  final String subTitulo;

  const Labels({
    Key? key,
    required this.ruta,
    required this.titulo,
    required this.subTitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text( this.titulo , style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 ) ),
          SizedBox( height: 10 ),
          GestureDetector(
            child: Text( this.subTitulo, style: TextStyle( color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold )  ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta );
            },
          )
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {

  const Logo({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only( top: 50 ),
        child: Column(
          children: <Widget>[

            Image( image: AssetImage('images/Milestone_2.png') ),
            SizedBox( height: 20 ),
          ],
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    Key? key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 5, left: 5, bottom: 5, right: 20 ),
      margin: EdgeInsets.only( bottom: 20 ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5
            )
          ]
      ),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon( this.icon, color: Colors.indigo,),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeholder
        ),
      ),
    );
  }
}