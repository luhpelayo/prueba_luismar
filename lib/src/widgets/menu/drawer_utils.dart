import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerUtils {
  static String photoURL =
      'https://i.pinimg.com/280x280_RS/42/03/a5/4203a57a78f6f1b1cc8ce5750f614656.jpg';
  static String? nameuser;
  static String? email;
  static String imagenpordefecto =
      'https://i.pinimg.com/280x280_RS/42/03/a5/4203a57a78f6f1b1cc8ce5750f614656.jpg';

  static void _session() async {
    print('iniciar sesion');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    photoURL = prefs.getString('photoURL')!;
    nameuser = prefs.getString('nameuser') ?? '';
    email = prefs.getString('email') ?? '';
    print('este es url $photoURL');
    print('este es url $nameuser');
    print('este es url $email');
    print('este es los valore $photoURL $email $nameuser');
    //setState(() {}); // No se necesita setState en este contexto
  }

  static void cerrarSesion() async {
    // Cerrar sesión en FirebaseAuth
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    // Cerrar sesión en GoogleSignIn
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('nameuser');
    prefs.remove('email');
    prefs.remove('photoURL');
    print('sesion cerrada');
  }

  static Widget buildDrawer(BuildContext context) {
    void _session() {
      DrawerUtils._session();
    }

    // Aquí colocas el código de la función buildDrawer
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            //color de cabecera
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 201, 29, 10),
            ),
            //fin de cabecera

            currentAccountPicture: GestureDetector(
              onTap: () {
               // Navigator.of(context).pushReplacementNamed('/perfil');
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
                Navigator.of(context).pushReplacementNamed('/indexcompra');
              } else {
                Navigator.of(context).pushReplacementNamed('/indexcompra');
                print('inicio');
              }
            },
          ),
          //noticias
          if (email == 'mateuspelayo@gmail.com') //solo mostrar al adm
            ListTile(
              leading: Icon(Icons.article),
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
}
