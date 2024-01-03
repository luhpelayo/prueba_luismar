//session
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}
class _PerfilScreenState extends State<PerfilScreen> {




//parte de

String photoURL='https://i.pinimg.com/280x280_RS/42/03/a5/4203a57a78f6f1b1cc8ce5750f614656.jpg';
String? nameuser;
String? email;
void initState() {
  super.initState();
 // checkIfLoggedIn();
 _session();
}


void _session() async {
  print('iniciar sesion');
 SharedPreferences prefs = await SharedPreferences.getInstance();
 photoURL =prefs.getString('photoURL')!;
 nameuser= prefs.getString('nameuser')?? '';
 email=prefs.getString('email')?? '';
 print('este es url $photoURL');
  print('este es url $nameuser');
   print('este es url $email');
     setState(() {}); // añade esta línea
}


void cerrarSesion() async {
  
    // Cerrar sesión en FirebaseAuth
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();

  // Cerrar sesión en GoogleSignIn
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();

  //eliminando todos los datos guardados en sahred preferes
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('nameuser');
  prefs.remove('email');
  prefs.remove('photoURL');
  print('sesion cerrada');

    
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
//fin de tap
          accountName: Text(nameuser?? 'Sin usuario'),
          //accountEmail: Text(idrol.toString()),
          accountEmail: Text(email?? 'Sin usuario'),
          //accountEmail: Text('pelayo@gmail.com'),
        ),

  ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          subtitle: Text('Principal'),
          onTap: () {
            if (email == 'mateuspelayo@gmail.com'){
              Navigator.of(context).pushReplacementNamed('/noticiasAdm');
            } else{
            Navigator.of(context).pushReplacementNamed('/noticias');
           print('inicio');
            }  },
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

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        //backgroundColor: Colors.blue,
      ),
      //menu
      drawer: buildDrawer(context),
      body: GestureDetector(
 


        child: ListView(
          children: [
    Container(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
    children: <Widget>[
       SizedBox(height: 20),
    Center(
  child: ClipOval(
    child: Image(
      image: NetworkImage(photoURL),
      height: 200,
      width: 200,
      fit: BoxFit.cover,
    ),
  ),
),
      SizedBox(height: 70),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person),
          SizedBox(width: 8),
          Text(nameuser?? 'Sin usuario', style: TextStyle(fontSize: 16)),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.work),
          SizedBox(width: 8),
          Text(email?? 'Sin usuario', style: TextStyle(fontSize: 16)),
        ],
      ),

      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Icon(Icons.location_on),
          SizedBox(width: 8),
          Text('Av.Bush 2do anillo', style: TextStyle(fontSize: 16)),
        ],
      ),

      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.calendar_today),

          SizedBox(width: 8),
          Text('28/07/1997', style: TextStyle(fontSize: 16)),
        ],
      ),
    ],
  ),
),


       
          ],
        ),
      ),



  


  );
}
}
