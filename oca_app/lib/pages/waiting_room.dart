// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class WaitingRoom extends StatefulWidget {
  const WaitingRoom({Key? key}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  int _nPlayers = 0;
  List<dynamic> _players = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleEvent(List<dynamic> message) {
    print("dentro de _handleEvent");
    // función que maneja los eventos recibidos desde otra clase
    setState(() {
      _players.addAll(message); // agregamos el mensaje a la lista
      _nPlayers = _players.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    SocketSingleton ss = SocketSingleton.instance;

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
            const FormNombreSala(),
            // PARTICIPANTES  **********************
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Jugadores: $_nPlayers",
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
                child: StreamBuilder<dynamic>(
                  stream: SocketSingleton.instance.listStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    print("snapshot.data = ${snapshot.data}");
                    return ListView.builder(
                      itemCount: snapshot.data
                          .length, // mostrar la cantidad de mensajes almacenados
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title:
                              Text(snapshot.data[index]), // mostrar el mensaje
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // BOTÓN "EMPEZAR PARTIDA" *****************
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // el parámetro indica el timeout de cada turno
                        //await ss.empezarPartida(15);
                        // HACER FUNCIONALIDAD DE EMPEZAR PARTIDA !!!!
                      },
                      style: GenericButton,
                      child: const Text(
                        "Empezar partida",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ss.destroyRoom();
                        // HACER FUNCIONALIDAD DE EMPEZAR PARTIDA !!!!
                      },
                      style: GenericButton,
                      child: const Text(
                        "Eliminar sala",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
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

class FormNombreSala extends StatelessWidget {
  const FormNombreSala({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 170, 250, 254),
          width: double.infinity,
          child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Nombre de la sala",
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: 'Caudex'),
              )),
          //child: Text() PONER EL NOMBRE DE LA SALA
        ),
      ),
    );
  }
}
