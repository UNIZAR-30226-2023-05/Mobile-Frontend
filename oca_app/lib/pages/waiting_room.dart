import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class WaitingRoom extends StatefulWidget {
  const WaitingRoom({Key? key}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  int nPlayers = 1;
  List<bool> playersPlaying = <bool>[true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 28, 100, 116),
        body: SafeArea(
            child: Column(
          children: [
            // CABECERA  **********************
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset('lib/images/logo.PNG',
                            width: 110, height: 110),
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              _showIntrucciones(context);
                            },
                            icon: const Icon(Icons.question_mark,
                                color: Colors.white, size: 45),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            // NOMBRE DE SALA  **********************
            Container(
              color: Colors.white,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                child: Container(
                  color: const Color.fromARGB(255, 170, 250, 254),
                  width: double.infinity,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Nombre de la sala",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Caudex'),
                      )),
                  //child: Text() PONER EL NOMBRE DE LA SALA
                ),
              ),
            ),
            // PARTICIPANTES  **********************
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Jugadores: $nPlayers",
                style: const TextStyle(
                    color: Colors.white, fontSize: 24, fontFamily: 'Caudex'),
              ),
            ),
            // COLUMNA DE SEIS ELEMENTOS **********************
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Column(children: [
                  Visibility(
                      visible: playersPlaying[0],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.black,
                      )),
                  Visibility(
                      visible: playersPlaying[1],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.green,
                      )),
                  Visibility(
                      visible: playersPlaying[2],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.black,
                      )),
                  Visibility(
                      visible: playersPlaying[3],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.purple,
                      )),
                  Visibility(
                      visible: playersPlaying[4],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.black,
                      )),
                  Visibility(
                      visible: playersPlaying[5],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.black,
                      ))
                ]),
              ),
            ),
            // BOTÓN "EMPEZAR PARTIDA" *****************
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // HACER FUNCIONALIDAD DE EMPEZAR PARTIDA !!!!
                    },
                    style: GenericButton,
                    child: const Text(
                      "Empezar partida",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void _showIntrucciones(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              title: const Text("Instrucciones"),
              content:
                  const Text("POP UP para mostrar las instrucciones del juego"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                )
              ],
            ));
  }
}
