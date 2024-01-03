import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../models/personal.dart';
import '../../services/personal_services.dart';
import '../personal/lista_personal.dart';

class HomeScreenAdm extends StatefulWidget {
  @override
  _HomeScreenAdmState createState() => _HomeScreenAdmState();
}

class _HomeScreenAdmState extends State<HomeScreenAdm> {
  String nameuser = '';

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameuser = prefs.getString('nameuser') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headlineSmall;
    String PrimerNombre = nameuser!.split(' ')[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hola,"),
        backgroundColor: Color.fromARGB(255, 201, 29, 10),
        automaticallyImplyLeading: false, // Esto oculta la flecha de retroceso
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
                  child: const Text('Lista de Personal',
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
