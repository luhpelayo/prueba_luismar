import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<void> updatePersonal(String apiUrl, int personalId, Map<String, dynamic> data, File? imageFile) async {
  try {
    //var request = http.MultipartRequest('PUT', Uri.parse('$apiUrl/api/personal/$personalId'));
  var request = http.MultipartRequest('POST', Uri.parse('${apiUrl}api/personal/$personalId'));
    // Adjunta los datos al cuerpo de la solicitud
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Adjunta el archivo de imagen al cuerpo de la solicitud
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('img', imageFile.path, filename: basename(imageFile.path)),
      );
    }
    // Enviar solicitud POST
    var response = await request.send();

    // Procesar la respuesta
    if (response.statusCode == 200) {
      // La personal se actualizó correctamente
      var jsonResponse = jsonDecode(await response.stream.bytesToString());
      print('Mensaje: ${jsonResponse["message"]}');
    } else {
      // Ocurrió un error en la solicitud
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
