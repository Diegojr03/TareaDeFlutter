class Intento {
  int puntuacion;
  DateTime fecha;
  String text;

  Intento({required this.puntuacion, required this.fecha,required this.text});

  // Agrega este método toJson
  Map<String, dynamic> toJson() {
    return {
      'puntuacion': puntuacion.toString(), // Asegurar que 'puntuacion' sea de tipo int
      'fecha': fecha.toIso8601String(),
      'text':"",
      // ... otras propiedades
    };
  }

  // Agrega este método fromJson para convertir el JSON a una instancia de Intento
  factory Intento.fromJson(Map<String, dynamic> json) {
    return Intento(
    puntuacion: json['puntuacion'], // Asegurar que 'puntuacion' sea interpretado como un entero
    fecha: DateTime.parse(json['fecha']),
    text: "",
  );
  }
}