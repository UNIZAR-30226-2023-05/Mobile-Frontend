// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/components/global_stream_controller.dart';

import '../components/User_instance.dart';

class WaitingRoom extends StatefulWidget {
  final String nameRoom; // nombre de la sala
  const WaitingRoom({Key? key, required this.nameRoom}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  List<dynamic> players = [];
  StreamSubscription<dynamic>? streamSubscription;

  @override
  void initState() {
    print("initState()");

    super.initState();
  }

  @override
  void dispose() async {
    print("dispose()");
    /*
    try {
      await streamSubscription!.cancel();
      print('La suscripción se ha cancelado correctamente.');
    } catch (e) {
      print('Error al cancelar la suscripción: $e');
    }*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SocketSingleton ss = SocketSingleton.instance;
    ss.setContext(context);

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
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.nameRoom,
                        style: const TextStyle(
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: StreamBuilder<dynamic>(
                  stream: GlobalStreamController().playersStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasData) {
                          List<dynamic> players = snapshot.data;
                          bool isLeader = User_instance.instance.soyLider;
                          return ListView.builder(
                            itemCount: players.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (players[index] is Map<String, dynamic>) {
                                return Container(
                                  height:
                                      60, // Adjust the height as per your needs
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(players[index]['nickname']),
                                          if (isLeader &&
                                              players[index]['nickname'] !=
                                                  User_instance
                                                      .instance.nickname)
                                            TextButton(
                                              onPressed: () {
                                                print(
                                                    players[index]['nickname']);
                                                ss.removePlayerFromRoom(
                                                    players[index]['nickname']);
                                              },
                                              child: Text("Expulsar"),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(); // Return an empty container when the data format is not as expected
                              }
                            },
                          );
                        } else {
                          return Center(child: Text('No hay jugadores'));
                        }
                    }
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
                        await ss.empezarPartida(30);
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
                        /*
                        try {
                          await streamSubscription!.cancel();
                          print(
                              'La suscripción se ha cancelado correctamente.');
                        } catch (e) {
                          print('Error al cancelar la suscripción: $e');
                        }*/
                        User_instance.instance.soyLider
                            ? await ss.destroyRoom()
                            : await ss.leaveRoom();
                        // Volver a pantalla de inicio
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Main_Menu_Page()));
                      },
                      style: GenericButton,
                      child: User_instance.instance.soyLider
                          ? const Text(
                              "Eliminar sala",
                              style: TextStyle(fontSize: 25),
                            )
                          : const Text(
                              "Abandonar sala",
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
