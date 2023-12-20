import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tarea1fluter/Intento.dart';
import 'pantallaTabla.dart';

class ResultsScreen extends StatelessWidget {
  final int score;

  ResultsScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Puntuación: $score/4',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                 onPressed: () async {
                var a = await fetchHistorial();
                print('a $a');
                Intento nuevoIntento =
                    Intento(puntuacion: score, fecha: DateTime.now(), text:a);
                await postHistorial(nuevoIntento);

                Navigator.of(
                  context).push(
                  MaterialPageRoute(
                    builder: (context) => HistorialScreen(historial: const [],),
                  ),
                );
              },
              child: Text('Guardar y ver historial'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarHistorial(BuildContext context) async {
    try {
      print("HOLA");
      final historial = await fetchHistorial();
      if (historial != null) {
        print(historial);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistorialScreen(historial: [],),
        ));
      } else {
        print('El historial es nulo.');
        // Manejar el caso cuando el historial es nulo
      }
    } catch (e) {
      print('Error al obtener el historial: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al obtener el historial: $e'),
        ),
      );
    }
  }
}
