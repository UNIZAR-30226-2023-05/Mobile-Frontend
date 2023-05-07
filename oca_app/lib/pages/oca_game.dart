import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/components/fichas.dart';
import 'package:oca_app/components/oca_game_grid.dart';

class Oca_game extends StatefulWidget {
  Oca_game({Key? key}) : super(key: key);

  @override
  _Oca_gameState createState() => _Oca_gameState();
}

class _Oca_gameState extends State<Oca_game> {
  final String nombreSala = 'Nombre de la sala';

  int posicionFicha1 = 0;
  double leftFicha1 = calcularCoordenadas(1, 0)[0].toDouble();
  double topFicha1 = calcularCoordenadas(1, 0)[1].toDouble();

  int posicionFicha2 = 0;
  double leftFicha2 = calcularCoordenadas(2, 0)[0].toDouble();
  double topFicha2 = calcularCoordenadas(2, 0)[1].toDouble();

  int posicionFicha3 = 0;
  double leftFicha3 = calcularCoordenadas(3, 0)[0].toDouble();
  double topFicha3 = calcularCoordenadas(3, 0)[1].toDouble();

  int posicionFicha4 = 0;
  double leftFicha4 = calcularCoordenadas(4, 0)[0].toDouble();
  double topFicha4 = calcularCoordenadas(4, 0)[1].toDouble();

  void actualizarPosicion() {
    setState(() {
      posicionFicha1++;
      leftFicha1 = calcularCoordenadas(1, posicionFicha1)[0].toDouble();
      topFicha1 = calcularCoordenadas(1, posicionFicha1)[1].toDouble();

      posicionFicha2++;
      leftFicha2 = calcularCoordenadas(2, posicionFicha2)[0].toDouble();
      topFicha2 = calcularCoordenadas(2, posicionFicha2)[1].toDouble();

      posicionFicha3++;
      leftFicha3 = calcularCoordenadas(3, posicionFicha3)[0].toDouble();
      topFicha3 = calcularCoordenadas(3, posicionFicha3)[1].toDouble();

      posicionFicha4++;
      leftFicha4 = calcularCoordenadas(4, posicionFicha4)[0].toDouble();
      topFicha4 = calcularCoordenadas(4, posicionFicha4)[1].toDouble();

      print(posicionFicha1);
    });
  }

  @override
  Widget build(BuildContext context) {
    FichaWidget ficha1 = FichaWidget(
        nombre: 'Ficha 1',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha2 = FichaWidget(
        nombre: 'Ficha 1',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha3 = FichaWidget(
        nombre: 'Ficha 1',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha4 = FichaWidget(
        nombre: 'Ficha 1',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));

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
                  Positioned(child: ficha1, left: leftFicha1, top: topFicha1),
                  Positioned(child: ficha2, left: leftFicha2, top: topFicha2),
                  Positioned(child: ficha3, left: leftFicha3, top: topFicha3),
                  Positioned(child: ficha4, left: leftFicha4, top: topFicha4),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    actualizarPosicion();
                  },
                  child: const Text('Tirar dados')),
            ],
          ),
        ));
  }
}
