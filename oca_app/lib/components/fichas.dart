import 'package:flutter/material.dart';

class FichaWidget extends StatelessWidget {
  final String nombre;
  final int posicion;
  final Image imagen;

  FichaWidget(
      {required this.nombre, required this.posicion, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        children: [
          imagen,
          //Text(nombre),
        ],
      ),
    );
  }

  double calcularX(int posicion) {
    // código para calcular la posición horizontal de la ficha en el tablero
    return 3;
  }

  double calcularY(int posicion) {
    return 3;
  }
}
