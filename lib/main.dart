import 'package:flutter/material.dart';
import 'resultados.dart';

//import 'package:collection/collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemoryGameScreen(),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late List<String> imagePaths;
  late List<Widget> imageWidgets;
  late List<Widget?> numberButtons;
  late List<Widget> miniImages;
  late List<bool> buttonPressed;

  bool isGameStarted = false;

  @override
  void initState() {
    super.initState();
    // Rellenar la lista de rutas de imágenes con las imágenes que desees
    imagePaths = [
      "imagenes/imagen0.png",
      "imagenes/imagen1.png",
      "imagenes/imagen2.png",
      "imagenes/imagen3.png",
    ];
    // Inicializar la lista de widgets de imágenes con las imágenes en línea horizontal
    imageWidgets = imagePaths.map((path) {
      return Image.asset(
        path,
        width: 120,
        height: 120,
      );
    }).toList();
    // Inicializar la lista de botones de números en null
    numberButtons = List.filled(4, null);
    // Inicializar la lista de miniaturas de imágenes en null
    miniImages = List.filled(4, Container());

    buttonPressed = List.filled(4, false);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto de bienvenida
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Bienvenido al juego de memoria,\nmemoriza las imágenes antes de darle al botón jugar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            // Mostrar las imágenes o botones de números según el estado del juego
            isGameStarted
                ? Column(
                    children: [
                      // Botones de números
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return ElevatedButton(
                            onPressed: () {
                              handleNumberButtonClick(index + 1);
                              setState(() {
                                buttonPressed[index] = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonPressed[index] ? Colors.grey : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      // Miniaturas de imágenes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: miniImages,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: imageWidgets,
                  ),
            SizedBox(height: 50),
            // Botón para jugar más abajo y un poco más grande
            ElevatedButton(
              onPressed: () {
                // Lógica para iniciar el juego o realizar alguna acción
                setState(() {
                  isGameStarted = true;
                  // Ocultar las imágenes y mostrar botones de números
                  imageWidgets = List.filled(4, Container());
                  numberButtons = List.generate(4, (index) {
                    return ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  });
                  // Mostrar miniaturas de imágenes debajo de los botones
                  miniImages = [
                    Image.asset(
                      imagePaths[2],
                      width: 40,
                      height: 40,
                    ),
                    Image.asset(
                      imagePaths[0],
                      width: 40,
                      height: 40,
                    ),
                    Image.asset(
                      imagePaths[3],
                      width: 40,
                      height: 40,
                    ),
                    Image.asset(
                      imagePaths[1],
                      width: 40,
                      height: 40,
                    ),
                  ];
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              ),
              child: Text('Jugar', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            // Botón de Resultados
            ElevatedButton(
              onPressed: () {
                
                checkResults();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              ),
              child: Text('Resultados', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para reiniciar el juego
                setState(() {
                  isGameStarted = false;
                  // Restaurar las imágenes y botones a su estado original
                  imageWidgets = imagePaths.map((path) {
                    return Image.asset(
                      path,
                      width: 120,
                      height: 120,
                    );
                  }).toList();
                  numberButtons = List.filled(4, null);
                  miniImages = List.filled(4, Container());
                  buttonPressed = List.filled(4, false);
                  userOrder = [];
                  puntuacionFinal = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              ),
              child: Text('Reiniciar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  int puntuacionFinal = 0;
  
  List<int?> userOrder = [];

  // Función para manejar el clic en los botones de números
  void handleNumberButtonClick(int number) {
    setState(() {
      userOrder.add(number);
    });
  }

  // Función para comprobar los resultados y navegar a la pantalla de resultados
  void checkResults() {
    // Verificar la puntuación
      List<int> correctOrder = [2, 4, 1, 3];

      puntuacionFinal = 0;

      for (int i = 0; i < correctOrder.length; i++) {
        if (userOrder.length > i && correctOrder[i] == userOrder[i]) {
         puntuacionFinal++;
        }

      }
      

      Navigator.push(
        context,
        MaterialPageRoute(
          
          builder: (context) => ResultsScreen(score: puntuacionFinal ),
        ),
      );
  }
}
