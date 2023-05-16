import 'package:flutter/material.dart';

class FichaWidget extends StatelessWidget {
  final String nombre;
  final int posicion;
  final Image imagen;
  final bool visible;

  FichaWidget(
      {required this.nombre,
      required this.posicion,
      required this.imagen,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: visible ? 1.0 : 0.0,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          children: [
            imagen,
            //Text(nombre),
          ],
        ),
      ),
    );
  }
}
