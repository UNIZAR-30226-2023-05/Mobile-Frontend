import 'package:flutter/material.dart';

class Ficha {
  final Image image;
  final int id;
  final int posicion;

  Ficha({required this.image, required this.id, required this.posicion});
}

List<Ficha> fichas = [
  Ficha(id: 1, posicion: 0),
  Ficha(id: 2, posicion: 0),
];
