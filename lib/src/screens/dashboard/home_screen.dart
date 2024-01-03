import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../models/personal.dart';
import '../../services/personal_services.dart';
import '../login/login_screen.dart';
import '../personal/lista_personal.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  User? user;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  HomeScreen(
      {required this.user,
      super.key,
      required this.auth,
      required this.googleSignIn});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String photoURL =
      'https://i.pinimg.com/280x280_RS/42/03/a5/4203a57a78f6f1b1cc8ce5750f614656.jpg';
  String? nameuser;
  String? email;
  void initState() {
    super.initState();
    // checkIfLoggedIn();
    photoURL = widget.user!.photoURL!;
    nameuser = widget.user?.displayName;
    email = widget.user?.email;
    _session();
  }

  void _session() async {
    print('inicio de sesio home screen');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nameuser', nameuser!);
    prefs.setString('email', email!);
    prefs.setString('photoURL', photoURL);
    print('este es los valore $photoURL $email $nameuser');
  }

  void cerrarSesion() async {
    try {
      await widget.auth.signOut();

      if (await widget.googleSignIn.isSignedIn()) {
        await widget.googleSignIn.signOut();
        widget.user = null;
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));

        //eliminando todos los datos guardados en sahred preferes
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('nameuser');
        prefs.remove('email');
        prefs.remove('photoURL');
        print('sesion cerrada');
      }
    } catch (e) {
      print(e);
    }
  }

  //menu
  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            //color de cabecera
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            //fin de cabecera

            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/perfil');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(photoURL),
              ),
            ),

            accountName: Text(nameuser ?? 'Sin usuario'),
            //accountEmail: Text(idrol.toString()),
            accountEmail: Text(email ?? 'Sin usuario'),
            //accountEmail: Text('pelayo@gmail.com'),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            subtitle: Text('Principal'),
            onTap: () {
              if (email == 'mateuspelayo@gmail.com') {
                Navigator.of(context).pushReplacementNamed('/noticiasAdm');
              } else {
                Navigator.of(context).pushReplacementNamed('/noticias');
                print('inicio');
              }
            },
          ),
          //noticias
          if (email == 'mateuspelayo@gmail.com') //solo mostrar al adm
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Subir Noticias'),
              subtitle: Text('Agregar'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/homenoticias');
                print('Noti');
              },
            ),
          if (email == 'mateuspelayo@gmail.com') //solo mostrar al adm
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Noticias'),
              subtitle: Text('Ver'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/noticias');
                print('Noti');
              },
            ),
          //hasta aqui solo administrador
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('logout'),
            subtitle: Text('finalizar sesion'),
            onTap: () {
              cerrarSesion();
              Navigator.of(context).pushReplacementNamed('/welcome');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headlineSmall;
    String PrimerNombre = nameuser!.split(' ')[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hola,"),
        backgroundColor: Color.fromARGB(255, 201, 29, 10),
        automaticallyImplyLeading: false,
      ),
      //menu
      //drawer: buildDrawer(context),
      body: Container(
        //color: Colors.black,
        color: Color.fromARGB(255, 201, 29, 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLiquidFill(
                text: 'BIENVENIDO, $PrimerNombre',
                //waveColor:  Color.fromARGB(255, 108, 191, 235),
                waveColor: Color.fromARGB(255, 251, 251, 251),
                //boxBackgroundColor: const Color.fromARGB(255, 11, 10, 10)!,

                boxBackgroundColor: Color.fromARGB(255, 201, 29, 10),
                textStyle: TextStyle(
                    fontSize: 60.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                boxHeight: 500.0,
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    //ver lista de personal
                    List<Personal> listaPersonales = await fetchPersonales();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListaPersonal(listaPersonales: listaPersonales)),
                    );
                  },
                  child: const Text('Comenzar',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
