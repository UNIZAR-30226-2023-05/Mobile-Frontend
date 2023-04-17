import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/components/fichas.dart';

class Oca_game extends StatelessWidget {
  Oca_game({super.key});

  final String nombreSala = 'Nombre de la sala';
  FichaWidget ficha1 = FichaWidget(
      nombre: 'Ficha 1',
      posicion: 4,
      imagen: Image.asset('lib/images/Skin_dorada.png',
          width: 15, height: 15, fit: BoxFit.contain));
  FichaWidget ficha2 = FichaWidget(
      nombre: 'Ficha 2',
      posicion: 4,
      imagen: Image.asset('lib/images/Skin_rosa.png',
          width: 15, height: 15, fit: BoxFit.contain));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 28, 100, 116),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: SizedBox(
                            height: 50,
                            width: 401,
                            child: Card(
                              color: const Color.fromARGB(255, 195, 250, 254),
                              child: Center(
                                child: Text(nombreSala,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: 'Caudex')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: ElevatedButton(
                        style: GenericButtonSmall,
                        onPressed: () {},
                        child: const Text('Abandonar sala')),
                  )
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    'lib/images/oca_tablero.PNG',
                    width: 400,
                    height: 400,
                  ),
                  Positioned(child: ficha1, left: 135, top: 145),
                  Positioned(child: ficha2, left: 50, top: 342),
                ],
              ),
            ],
          ),
        ));
  }
}
