// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class WaitingRoom extends StatefulWidget {
  WaitingRoom({Key? key}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  final List<String> _players = []; // lista de mensajes
  final StreamController<String> _controller = StreamController<String>(); // controlador de eventos

  @override
  void dispose() {
    _controller.close(); // cerrar el streamController cuando se destruye el widget
    super.dispose();
  }

  void _handleEvent(String message) {
    print("dentro de _handleEvent");
    // función que maneja los eventos recibidos desde otra clase
    setState(() {
      _players.add(message); // agregamos el mensaje a la lista
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
                "Jugadores: ${_players.length}",
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
                child: StreamBuilder<String>(
                  stream: _controller.stream, // escuchar eventos desde el controlador
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      _handleEvent(snapshot.data!); // manejar evento si hay datos
                    }
                    return ListView.builder(
                      itemCount: _players.length, // mostrar la cantidad de mensajes almacenados
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_players[index]), // mostrar el mensaje
                        );
                      },
                    );
                  },
                ),),),
            // BOTÓN "EMPEZAR PARTIDA" *****************
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(children: [
                        ElevatedButton(
                          onPressed: () async {
                            // el parámetro indica el timeout de cada turno
                            await ss.empezarPartida(15);
                            // HACER FUNCIONALIDAD DE EMPEZAR PARTIDA !!!!
                          },
                          style: GenericButton,
                          child: const Text(
                            "Empezar partida",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                const SizedBox(height: 30,),
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
            ),],),
              ),
            )
        ),],),),);
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
