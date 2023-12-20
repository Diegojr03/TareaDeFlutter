import 'dart:convert';
import 'package:flutter/material.dart';
import 'Intento.dart'; // Asegúrate de importar la clase Intento
import 'package:http/http.dart' as http;

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key, required List<String> historial});

  @override
  State<HistorialScreen> createState() => _HistorialScreen();
}
List<String> entradas = [];
class _HistorialScreen extends State<HistorialScreen> {


  final List<String> historial = [];
  
@override
void initState() {
  super.initState();
  fetchHistorial().then((entrada) {
    setState(() {
      historial.add(entrada);
      print('Historial Length: ${historial.length}');
    });
  });
}

  

  @override
Widget build(BuildContext context) {
  print('Historial Length in Build: ${historial.length}');
  return Scaffold(
    appBar: AppBar(
      title: Text('Historial de Intentos'),
    ),
    body: Center(
      child: ListView(
        children: historial.map((entrada) {
          return Card(
            child: ListTile(
              title: Text(entrada),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

}

Future<void> postHistorial(Intento intento) async {
  try {
    Uri uri = Uri.parse(
        'https://damcweeqvnzirmvjxikz.supabase.co/rest/v1/tareaFlutter?select=*');
    final headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhbWN3ZWVxdm56aXJtdmp4aWt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1MzgyODksImV4cCI6MjAxNTExNDI4OX0.NVoy_-YQb3gBey85dJ7-irkI8Hi7rNenjnGtPXhpzeo',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhbWN3ZWVxdm56aXJtdmp4aWt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1MzgyODksImV4cCI6MjAxNTExNDI4OX0.NVoy_-YQb3gBey85dJ7-irkI8Hi7rNenjnGtPXhpzeo'
    };
    final cuerpoJSON =
        intento.toJson(); // Utilizando el método toJson de la clase Intento
    print('Enviando: $cuerpoJSON');

    final response = await http.post(uri, headers: headers, body: cuerpoJSON);
    
    
    print("1");
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Lógica a realizar en caso de éxito
      print('Registro exitoso');
    } else {
      // Lógica a realizar en caso de fallo
      print('Error en el registro. Código de estado: ${response.statusCode}');
    }
  } catch (e) {
    // Lógica a realizar en caso de error
    print('Error en el registro: $e');
  }
}

Future<String> fetchHistorial() async {
  final response = await http.get(
    Uri.parse(
        'https://damcweeqvnzirmvjxikz.supabase.co/rest/v1/tareaFlutter?select=*'), // Reemplaza con la URL de tu API

    headers: {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhbWN3ZWVxdm56aXJtdmp4aWt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1MzgyODksImV4cCI6MjAxNTExNDI4OX0.NVoy_-YQb3gBey85dJ7-irkI8Hi7rNenjnGtPXhpzeo',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhbWN3ZWVxdm56aXJtdmp4aWt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk1MzgyODksImV4cCI6MjAxNTExNDI4OX0.NVoy_-YQb3gBey85dJ7-irkI8Hi7rNenjnGtPXhpzeo'
    },
  );

  final List<dynamic> data = json.decode(response.body);
  print('API Response: $data');
  
  String entrada = "El resultado es : ${data[0]["puntuacion"]} Hecho el: ${data[0]["fecha"]}";
  entradas.add(entrada);
  print('Entradas: $entradas');
  return entrada;


}

  // final List<Intento> intentos =
  //     data.map((item) => Intento.fromJson(item)).toList();
  // Intento intent = intentos[0];
  // print('Lista de intentos: $intentos');

  // return (intent);
