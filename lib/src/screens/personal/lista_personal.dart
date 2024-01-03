import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../config/env.dart';
import '../../models/personal.dart';
import '../../widgets/menu/drawer_utils.dart';

import 'edit_foto_personal.dart';

class ListaPersonal extends StatefulWidget {

 final List<Personal> listaPersonales;

  ListaPersonal({required this.listaPersonales});
  @override
  State<ListaPersonal> createState() => _ListaPersonalState();
}


class _ListaPersonalState extends State<ListaPersonal> {

  void initState() {
    super.initState();
    _session(); // Llama al método _session() en initState()
  }

  void _session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DrawerUtils.photoURL = prefs.getString('photoURL') ?? DrawerUtils.photoURL;
    DrawerUtils.nameuser = prefs.getString('nameuser') ?? '';
    DrawerUtils.email = prefs.getString('email') ?? '';
    print('este es url ${DrawerUtils.photoURL}');
    print('este es url ${DrawerUtils.nameuser}');
    print('este es url ${DrawerUtils.email}');
    setState(() {}); // Actualiza el estado del StatefulWidget
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Personales'),
        backgroundColor: Color.fromARGB(255, 201, 29, 10),
      ),
       drawer: DrawerUtils.buildDrawer(context),
      body: widget.listaPersonales.isEmpty
          ? Center(
              child: Text('No hay personales disponibles.'),
            )
          : ListView.builder(
              itemCount: widget.listaPersonales.length,
              itemBuilder: (context, index) {
                Personal personal = widget.listaPersonales[index];

                return ListTile(
                  title: Text(
                    '${personal.nombre} ${personal.apellidoPaterno} ${personal.apellidoMaterno}',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CI: ${personal.ci}'),
                      Text('Teléfono: ${personal.telefono}'),
                    ],
                  ),
                  leading: CircleAvatar(
                    //backgroundImage: NetworkImage(personal.urlImg),

                    backgroundImage: NetworkImage(
                        '${Env.apiEndpoint}${personal.urlImg}'),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Implementa la acción de editar según tus necesidades
                          // Por ejemplo, puedes navegar a una pantalla de edición
                          // o mostrar un cuadro de diálogo de edición.
                          // Puedes pasar la información del personal a la pantalla de edición.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //builder: (context) => CambiarFotoPersonal(personal: personal),
                              builder: (context) =>
                                  EditFotoPersonal(personal: personal),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                  onTap: () {
                    // Implementa la acción que deseas al hacer clic en un elemento
                    // Por ejemplo, puedes navegar a una página de detalles.
                  },
                );
              },
            ),
    );
  }
}
