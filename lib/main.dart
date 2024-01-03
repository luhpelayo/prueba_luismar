
import 'package:prueba_luismar/src/screens/login/login_screen.dart';
import 'package:prueba_luismar/src/screens/login/perfil_screen.dart';
import 'package:prueba_luismar/src/screens/login/register_screen.dart';
import 'package:prueba_luismar/src/screens/welcome/welcome_inicio.dart';
import 'package:prueba_luismar/src/screens/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


//providers 
import 'package:prueba_luismar/src/screens/dashboard/home_screen_adm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   //para agregar tema de un color para todas las vistas
    /*   final theme = ThemeData(
      primarySwatch: MaterialColor(
        0xFF9999FF,
        <int, Color>{
          50: Color.fromRGBO(255, 231, 235, 1),
          100: Color(0xFFFFC3D0),
          200: Color(0xFFFFA0B5),
          300: Color(0xFFFF7D9A),
          400: Color(0xFFFF5B80),
          500: Color(0xFFD90429),
          600: Color(0xFFB2001F),
          700: Color(0xFF8F0016),
          800: Color(0xFF6D000D),
          900: Color(0xFF4A0003),
        },
      ),
     // brightness: AppController.instance.isDartTheme ? Brightness.dark : Brightness.light,
    );
   */
      final theme = ThemeData(
      primaryColor: Color.fromARGB(255, 201, 29, 10),
      primaryColorBrightness: Brightness.light,
      // Otros ajustes de tema según sea necesario
    );
    return 
   
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/inicio",
      
      routes: {
        "/welcome": (context) => const WelcomeScren(),
        "/home": (context) =>  HomeScreenAdm(),
        "/inicio": (context) =>  WelcomeInicio(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/perfil": (context) =>  PerfilScreen(),
     
      },
      //theme: ThemeData(useMaterial3: true),
    
    );
  }
}
