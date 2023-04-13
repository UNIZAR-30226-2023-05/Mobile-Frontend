import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class Oca_game extends StatelessWidget {
  Oca_game({super.key});

  final String nombreSala = 'Nombre de la sala';

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
              Image.asset('lib/images/oca_tablero.PNG',
                  width: 350, height: 350),
            ],
          ),
        ));
  }
}
