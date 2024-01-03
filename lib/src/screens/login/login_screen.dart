import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/env.dart';
import '../dashboard/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // User? user1;
  Future<void> _login() async {
    print('Aqui entro');

    final String apiUrl = '${Env.apiEndpoint}api/login';
    print('URL de la API: $apiUrl');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email.text,
          'password': password.text,
        },
      );

      print('Solicitud realizada');

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        final Map<String, dynamic> data = json.decode(response.body);

        // Aquí puedes manejar la respuesta según tus necesidades
        print('Mensaje: ${data["message"]}');
        print('Usuario: ${data["user"]}');

        // Puedes almacenar información del usuario en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('nameuser', data["user"]["name"]);
        prefs.setString('email', data["user"]["email"]);
        // Agrega más campos según sea necesario
        // Navegar a la pantalla "/home"
        Navigator.pushNamed(context, "/home");
        // También puedes actualizar tus variables locales

        // Continúa con otras acciones, como navegar a otra pantalla, etc.
      } else {
        // La solicitud falló
        print('Error en la solicitud: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
      }
    } catch (error) {
      // Manejar errores si ocurren
      print('Error al realizar la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    loginWithsGoogle() async {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(authCredential);
        print(userCredential.user);
        return userCredential;
      } catch (e) {
        print(e);
        return null;
      }
    }

    final _formKey = GlobalKey<FormState>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.amber,
        backgroundColor: Color.fromARGB(255, 201, 29, 10),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text("Register"),
          ),
        ],
      ),
      //backgroundColor: Colors.amber,
      backgroundColor: Color.fromARGB(
          255, 201, 29, 10), // Cambia el color de fondo a #055199
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Como te gustaria iniciar sesion.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: size.height * 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  Form(
                    //key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 70, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _email(email),
                          const SizedBox(
                            height: 15,
                          ),
                          _password(password),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _login();
                              },
                              style: ElevatedButton.styleFrom(
                                //backgroundColor: Colors.black,
                                backgroundColor:
                                    Color.fromARGB(255, 201, 29, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Entrar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // _googleButton(),
                  _googleButton(
                    loginWithsGoogle,
                    context,
                    firebaseAuth,
                    googleSignIn,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // _facebookButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _googleButton(Future<UserCredential?> loginWithsGoogle(),
      BuildContext context, FirebaseAuth auth, GoogleSignIn googleSignIn) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        onPressed: () async {
          UserCredential? userCredentialFinal = await loginWithsGoogle();
          if (userCredentialFinal != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              //TODO: Quitar todas las pantallas
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  user: userCredentialFinal.user,
                  auth: auth,
                  googleSignIn: googleSignIn,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          children: [
            Image.network(
              'https://rotulosmatesanz.com/wp-content/uploads/2017/09/2000px-Google_G_Logo.svg_.png',
              width: 35,
              height: 35,
            ),
            const Spacer(),
            const Text(
              "Cotinue with Google",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _facebookButton() {
    return GestureDetector(
      onTap: () => print("FACEBOOK"),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        width: 335,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/2048px-Facebook_f_logo_%282019%29.svg.png',
              width: 35,
              height: 35,
            ),
            const Spacer(),
            const Text(
              "Cotinue with Facebook",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // child: ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //   ),
        // child: Row(
        //   children: [
        //     Image.network(
        //       'https://rotulosmatesanz.com/wp-content/uploads/2017/09/2000px-Google_G_Logo.svg_.png',
        //       width: 35,
        //       height: 35,
        //     ),
        //     const Spacer(),
        //     const Text(
        //       "Cotinue with Google",
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),
        //     ),
        //     const Spacer(),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.arrow_forward_outlined,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        // ),
      ),
    );
  }

  TextFormField _password(TextEditingController val) {
    return TextFormField(
      controller: val,
       obscureText: true, 
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es obligatorio';
        }
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }

  TextFormField _email(TextEditingController val) {
    return TextFormField(
      controller: val,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email', // Cambiar de 'Username' a 'Email'
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }
}
