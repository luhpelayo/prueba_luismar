import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/env.dart';
import '../models/personal.dart';

Future<List<Personal>> fetchPersonales() async {
  final String apiUrl = '${Env.apiEndpoint}api/personal';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final List<dynamic> personalsData = data['personals']['data'];

    List<Personal> personals = personalsData.map((json) => Personal.fromJson(json)).toList();

    return personals;
  } else {
    throw Exception('Error al cargar los datos del personal');
  }
}
