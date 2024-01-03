
import 'package:flutter/material.dart';

import '../../models/personal.dart';
class ViewPersonal extends StatefulWidget {
   final Personal personal;
  const ViewPersonal({required this.personal});

  @override
  _ViewPersonalState createState() => _ViewPersonalState();
}

class _ViewPersonalState extends State<ViewPersonal> {
 late TextEditingController _nombreController;
  late TextEditingController _apellidoPaternoController;


  @override
  void initState() {
    super.initState();

    // Inicializa los controladores con los datos actuales
    _nombreController = TextEditingController(text: widget.personal.nombre);
    _apellidoPaternoController = TextEditingController(text: widget.personal.apellidoPaterno);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Personal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _apellidoPaternoController,
                decoration: InputDecoration(labelText: 'Apellido Paterno'),
              ),
              // Agrega campos para otros datos

              ElevatedButton(
                onPressed: () {

                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}