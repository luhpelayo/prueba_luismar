import 'dart:async';
import 'package:flutter/material.dart';

//mantener session
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeInicio extends StatefulWidget {
  @override
  _WelcomeInicioState createState() => _WelcomeInicioState();
}

class _WelcomeInicioState extends State<WelcomeInicio> {
  //String nameuser = '';
  //String password = '';
  //String errorText = '';
  //int? idrol2;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      //Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      checkIfLoggedIn();
    });
  }

  void checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nameuser = prefs.getString('nameuser');
    String? email = prefs.getString('email');
    //String? photoURL = prefs.getString('photoURL');
    //int idrol = int.parse(prefs.getString('idrol') ?? '0');

    if (nameuser != null) {
      //elegir q vista va ver el usuario
      if (email == 'mateuspelayo@gmail.com') {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }

//fin de  session
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          checkIfLoggedIn();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Contenedor para la imagen con tamaño personalizado
              Container(
                width: 250, // Ancho personalizado
                height: 250, // Alto personalizado
                child: Image.asset('assets/animations/welcome.png'),
              ),
              SizedBox(height: 16),
              Text('¡Bienvenido!'),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
