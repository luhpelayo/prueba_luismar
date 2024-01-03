import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/env.dart';
import '../../models/personal.dart';
import '../../services/personal_services.dart';
import '../../services/update_personal_services.dart';
import 'lista_personal.dart';

class EditFotoPersonal extends StatefulWidget {
  final Personal personal;

  const EditFotoPersonal({required this.personal});

  @override
  _EditFotoPersonalState createState() => _EditFotoPersonalState();
}

class _EditFotoPersonalState extends State<EditFotoPersonal> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoPaternoController;
  late TextEditingController _apellidoMaternoController;
  late TextEditingController _telefonoController;
  late TextEditingController _ciController;
  late TextEditingController _generoController;
  late TextEditingController _estadoCivilController;
  late TextEditingController _direccionController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    _nombreController = TextEditingController(text: widget.personal.nombre);
    _apellidoPaternoController =
        TextEditingController(text: widget.personal.apellidoPaterno);
    _apellidoMaternoController =
        TextEditingController(text: widget.personal.apellidoMaterno);
    _telefonoController = TextEditingController(text: widget.personal.telefono);
    _ciController = TextEditingController(text: widget.personal.ci);
    _generoController = TextEditingController(text: widget.personal.genero);
    _estadoCivilController =
        TextEditingController(text: widget.personal.estadoCivil);
    _direccionController =
        TextEditingController(text: widget.personal.direccion);
  }

  Future<void> _updatePersonal() async {
    try {
      // Obtener los valores de los controladores
      String nombre = _nombreController.text;
      String apellidoPaterno = _apellidoPaternoController.text;
      String apellidoMaterno = _apellidoMaternoController.text;
      String telefono = _telefonoController.text;
      String ci = _ciController.text;
      String genero = _generoController.text;
      String estadoCivil = _estadoCivilController.text;
      String direccion = _direccionController.text;

      // Construir el mapa con los datos a enviar
      Map<String, dynamic> data = {
        'nombre': nombre,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'telefono': telefono,
        'ci': ci,
        'genero': genero,
        'estado_civil': estadoCivil,
        'direccion': direccion,
      };

      // Llamar a la función para actualizar la información personal
      await updatePersonal(
        'http://192.168.0.5:8080',
        widget.personal.id,
        data,
        _imageFile,
      );

      // Actualizar la imagen en la vista después de la actualización
      setState(() {
        // Puedes cambiar 'urlImg' al nombre de la propiedad que contiene la URL de la imagen en tu modelo
        widget.personal.urlImg =
            'nueva URL de la imagen'; // Reemplaza con la nueva URL de la imagen
      });

      //Ir a pagina de listado de personal una vez actualizada
      List<Personal> listaPersonales = await fetchPersonales();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ListaPersonal(listaPersonales: listaPersonales)),
      );

      // Puedes agregar aquí la navegación a otra pantalla o realizar otras acciones después de la actualización
    } catch (error) {
      print('Error al actualizar la información personal: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Foto de Perfil'),
        backgroundColor: Color.fromARGB(255, 201, 29, 10),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      // Mostrar la imagen actualizada en la vista después de la actualización
                      (_imageFile != null)
                          ? ClipOval(
                              child: Container(
                                height: 250,
                                width: 250,
                                child: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : (widget.personal.urlImg.isNotEmpty)
                              ? ClipOval(
                                  child: Container(
                                    height: 250,
                                    width: 250,
                                    child: Image.network(
                                      '${Env.apiEndpoint}${widget.personal.urlImg}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : SizedBox(), // Puedes ajustar esto según tus necesidades
                      ElevatedButton.icon(
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (pickedFile != null) {
                            setState(() {
                              _imageFile = File(pickedFile.path);
                            });
                          }
                        },
                        icon: Icon(Icons.add_a_photo),
                        label: Text(''),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 201, 29, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Nombre: ${_nombreController.text}'),
                        _buildLabel(
                            'Apellido Paterno: ${_apellidoPaternoController.text}'),
                        _buildLabel(
                            'Apellido Materno: ${_apellidoMaternoController.text}'),
                        _buildLabel('Teléfono: ${_telefonoController.text}'),
                        _buildLabel(
                            'Carnet de Identidad: ${_ciController.text}'),
                        _buildLabel('Género: ${_generoController.text}'),
                        _buildLabel(
                            'Estado Civil: ${_estadoCivilController.text}'),
                        _buildLabel('Dirección: ${_direccionController.text}'),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //actualizar
                    _updatePersonal();
                  },
                  child: const Text('Guardar Cambios',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 201, 29, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
