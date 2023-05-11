import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/components/fichas.dart';
import 'package:oca_app/components/oca_game_grid.dart';
import 'package:oca_app/components/global_stream_controller.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/components/User_instance.dart';

class Oca_game extends StatefulWidget {
  Oca_game({Key? key}) : super(key: key);

  @override
  _Oca_gameState createState() => _Oca_gameState();
}

class _Oca_gameState extends State<Oca_game> {
  final String nombreSala = 'Nombre de la sala';
  late int njugadores;
  User_instance userInstance = User_instance.instance;
  int _diceNumber = 1;

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

  void actualizarEstado() {
    setState(() {});
    // Aquí, puedes agregar el código para actualizar la posición basándote en _diceNumber
  }

  void actualizarJuego(Map<String, dynamic> res) {
    setState(() {
      _diceNumber =
          res['dice']; // Actualiza _diceNumber con el valor de 'dice' en 'res'
      actualizarPosicion(res['afterDice']);
      print("actualizarjuego: ");
      print(res);
    });
    // Aquí, puedes agregar el código para actualizar la posición basándote en _diceNumber
  }

  void actualizarPosicion(int casillas) {
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
  void initState() {
    super.initState();
    SocketSingleton.instance.onActualizarEstado = actualizarEstado;
    inicializarJuego();
  }

  void inicializarJuego() {
    SocketSingleton ss = SocketSingleton.instance;
    var value = ss.turnController.playersStreamController.value;
    if (value is List) {
      njugadores = value.length;
      print('Número de jugadores: $njugadores');
    } else {
      print('Error al obtener el número de jugadores');
      // Handle error or set njugadores to a default value
    }
  }

  @override
  Widget build(BuildContext context) {
    FichaWidget ficha1 = FichaWidget(
        visible: (1 <= njugadores),
        nombre: 'Ficha 1',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha2 = FichaWidget(
        visible: (2 <= njugadores),
        nombre: 'Ficha 2',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha3 = FichaWidget(
        visible: (3 <= njugadores),
        nombre: 'Ficha 3',
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha4 = FichaWidget(
        visible: (4 <= njugadores),
        nombre: 'Ficha 4',
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
              if (userInstance.isMyTurn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        SocketSingleton.instance
                            .jugarTurno()
                            .then((res) => actualizarJuego(res));
                      },
                      child: SizedBox(
                        height: 50.0, // Ajusta el tamaño como necesites
                        width: 50.0, // Ajusta el tamaño como necesites
                        child: Image.asset(
                            'lib/images/dado_cara_$_diceNumber.png'),
                      ),
                    ),
                    SizedBox(width: 10), // Espaciado entre la imagen y el texto
                    Text('Tirar dados'),
                  ],
                )
            ],
          ),
        ));
  }
}
