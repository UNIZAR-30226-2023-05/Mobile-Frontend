import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/components/fichas.dart';
import 'package:oca_app/components/oca_game_grid.dart';
import 'package:oca_app/components/global_stream_controller.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:rxdart/rxdart.dart';

import '../components/ChatMessages.dart';

class Oca_game extends StatefulWidget {
  Oca_game({Key? key}) : super(key: key);

  static void chatMsgRecevied(String senderName, String msg) {
    _Oca_gameState._chatMsgRecevied(senderName, msg);
  }

  @override
  _Oca_gameState createState() => _Oca_gameState();
}

class _Oca_gameState extends State<Oca_game> {
  final String nombreSala = 'Nombre de la sala';
  int njugadores = 2;
  User_instance userInstance = User_instance.instance;
  int _diceNumber = 1;
  late List<String> nombresJugadores;

  // Añadido
  static final BehaviorSubject<ChatMessage> chatController =
      BehaviorSubject<ChatMessage>();
  final TextEditingController msgCtrl = TextEditingController();
  List<ChatMessage> messages = [];
  final ScrollController _scrollController = ScrollController();

  int posicionFicha1 = 0;
  double leftFicha1 = calcularCoordenadas(1, 9, 2)[0].toDouble();
  double topFicha1 = calcularCoordenadas(1, 9, 2)[1].toDouble();

  int posicionFicha2 = 0;
  double leftFicha2 = calcularCoordenadas(2, 9, 2)[0].toDouble();
  double topFicha2 = calcularCoordenadas(2, 9, 2)[1].toDouble();

  int posicionFicha3 = 0;
  double leftFicha3 = calcularCoordenadas(3, 9, 2)[0].toDouble();
  double topFicha3 = calcularCoordenadas(3, 9, 2)[1].toDouble();

  int posicionFicha4 = 0;
  double leftFicha4 = calcularCoordenadas(4, 9, 2)[0].toDouble();
  double topFicha4 = calcularCoordenadas(4, 9, 2)[1].toDouble();

  int posicionFicha5 = 0;
  double leftFicha5 = calcularCoordenadas(5, 9, 2)[0].toDouble();
  double topFicha5 = calcularCoordenadas(5, 9, 2)[1].toDouble();

  int posicionFicha6 = 0;
  double leftFicha6 = calcularCoordenadas(6, 9, 2)[0].toDouble();
  double topFicha6 = calcularCoordenadas(6, 9, 2)[1].toDouble();

  void actualizarEstado() {
    setState(() {});
    // Aquí, puedes agregar el código para actualizar la posición basándote en _diceNumber
  }

  void actualizarJuego(Map<String, dynamic> res) {
    setState(() {
      if (res != {}) {
        _diceNumber = res[
            'dice']; // Actualiza _diceNumber con el valor de 'dice' en 'res'
        //actualizarPosicionFicha1(res['afterDice']);
        print("actualizarjuego: ");
        print(res);
      }
    });
    // Aquí, puedes agregar el código para actualizar la posición basándote en _diceNumber
  }

  void actualizarPosicionFicha1(int afterDice) {
    setState(() {
      posicionFicha1 = afterDice;
      leftFicha1 =
          calcularCoordenadas(1, posicionFicha1, njugadores)[0].toDouble();
      topFicha1 =
          calcularCoordenadas(1, posicionFicha1, njugadores)[1].toDouble();

      print("posicion ficha 1: " + posicionFicha1.toString());
    });
  }

  void actualizarPosicionFicha2(int afterDice) {
    setState(() {
      posicionFicha2 = afterDice;
      leftFicha2 =
          calcularCoordenadas(2, posicionFicha2, njugadores)[0].toDouble();
      topFicha2 =
          calcularCoordenadas(2, posicionFicha2, njugadores)[1].toDouble();

      print(posicionFicha2);
    });
  }

  void actualizarPosicionFicha3(int afterDice) {
    setState(() {
      posicionFicha3 = afterDice;
      leftFicha3 =
          calcularCoordenadas(3, posicionFicha3, njugadores)[0].toDouble();
      topFicha3 =
          calcularCoordenadas(3, posicionFicha3, njugadores)[1].toDouble();

      print(posicionFicha3);
    });
  }

  void actualizarPosicionFicha4(int afterDice) {
    setState(() {
      posicionFicha4 = afterDice;
      leftFicha4 =
          calcularCoordenadas(4, posicionFicha4, njugadores)[0].toDouble();
      topFicha4 =
          calcularCoordenadas(4, posicionFicha4, njugadores)[1].toDouble();

      print(posicionFicha4);
    });
  }

  void actualizarPosicionFicha5(int afterDice) {
    setState(() {
      posicionFicha4 = afterDice;
      leftFicha4 =
          calcularCoordenadas(5, posicionFicha4, njugadores)[0].toDouble();
      topFicha4 =
          calcularCoordenadas(5, posicionFicha4, njugadores)[1].toDouble();

      print(posicionFicha4);
    });
  }

  void actualizarPosicionFicha6(int afterDice) {
    setState(() {
      posicionFicha4 = afterDice;
      leftFicha4 =
          calcularCoordenadas(6, posicionFicha4, njugadores)[0].toDouble();
      topFicha4 =
          calcularCoordenadas(6, posicionFicha4, njugadores)[1].toDouble();

      print(posicionFicha4);
    });
  }

  @override
  void initState() {
    super.initState();
    SocketSingleton.instance.onActualizarEstado = actualizarEstado;
    SocketSingleton.instance.actualizarPosicionFicha1 =
        actualizarPosicionFicha1;
    SocketSingleton.instance.actualizarPosicionFicha2 =
        actualizarPosicionFicha2;
    SocketSingleton.instance.actualizarPosicionFicha3 =
        actualizarPosicionFicha3;
    SocketSingleton.instance.actualizarPosicionFicha4 =
        actualizarPosicionFicha4;
    SocketSingleton.instance.actualizarPosicionFicha5 =
        actualizarPosicionFicha5;
    SocketSingleton.instance.actualizarPosicionFicha6 =
        actualizarPosicionFicha6;
    actualizarPosicionFicha1(0);
    actualizarPosicionFicha2(0);
    actualizarPosicionFicha3(0);
    actualizarPosicionFicha4(0);
    actualizarPosicionFicha5(0);
    actualizarPosicionFicha6(0);

    inicializarJuego();
  }

  void inicializarJuego() {
    SocketSingleton ss = SocketSingleton.instance;
    var value = ss.turnController.playersStreamController.value;
    if (value is List<Map<String, dynamic>>) {
      nombresJugadores = value.map((map) => map['nickname'] as String).toList();
      njugadores = nombresJugadores.length;
      //print('Nombres de los jugadores: $nombresJugadores');
      //print('Número de jugadores: $njugadores');
    } else {
      print('Error al obtener el número de jugadores');
      // Handle error or set njugadores to a default value
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
    FichaWidget ficha1 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[0]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha2 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[1]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha3 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[2]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha4 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[3]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha5 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[2]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_dorada.png',
            width: 15, height: 15, fit: BoxFit.contain));

    FichaWidget ficha6 = FichaWidget(
        visible: true,
        nombre: "nombresJugadores[3]",
        posicion: posicionFicha1,
        imagen: Image.asset('lib/images/Skin_rosa.png',
            width: 15, height: 15, fit: BoxFit.contain));
            */

    FichaWidget? ficha1 = (1 <= njugadores)
        ? FichaWidget(
            visible: (1 <= njugadores),
            nombre: nombresJugadores[0],
            posicion: posicionFicha1,
            imagen: Image.asset('lib/images/Skin_dorada.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

    FichaWidget? ficha2 = (2 <= njugadores)
        ? FichaWidget(
            visible: (2 <= njugadores),
            nombre: nombresJugadores[1],
            posicion: posicionFicha2,
            imagen: Image.asset('lib/images/Skin_rosa.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

    FichaWidget? ficha3 = (3 <= njugadores)
        ? FichaWidget(
            visible: (3 <= njugadores),
            nombre: nombresJugadores[2],
            posicion: posicionFicha3,
            imagen: Image.asset('lib/images/Skin_dorada.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

    FichaWidget? ficha4 = (4 <= njugadores)
        ? FichaWidget(
            visible: (4 <= njugadores),
            nombre: nombresJugadores[3],
            posicion: posicionFicha4,
            imagen: Image.asset('lib/images/Skin_rosa.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

    FichaWidget? ficha5 = (5 <= njugadores)
        ? FichaWidget(
            visible: (5 <= njugadores),
            nombre: nombresJugadores[2],
            posicion: posicionFicha5,
            imagen: Image.asset('lib/images/Skin_dorada.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

    FichaWidget? ficha6 = (6 <= njugadores)
        ? FichaWidget(
            visible: (6 <= njugadores),
            nombre: nombresJugadores[3],
            posicion: posicionFicha6,
            imagen: Image.asset('lib/images/Skin_rosa.png',
                width: 15, height: 15, fit: BoxFit.contain))
        : null;

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
              Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                  // mainAxisAlignment: MainAxisAlignment.end,
                  child: Row(children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                                style: GenericButtonSmall,
                                onPressed: () {
                                  // Chat de partida
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 99, 128),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          titlePadding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          title: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Chat',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              )),
                                          content: Container(
                                            height: 500,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 28, 100, 116),
                                                    width: 2.0),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                color: const Color.fromARGB(
                                                    255, 195, 250, 254)),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: StreamBuilder<
                                                            ChatMessage>(
                                                        stream: chatController
                                                            .stream,
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    ChatMessage>
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            if (snapshot.data
                                                                    ?.username !=
                                                                User_instance
                                                                    .instance
                                                                    .nickname) {
                                                              messages.add(
                                                                  snapshot
                                                                      .data!);
                                                            }
                                                          }
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            // Ajusta el scroll a la posición más reciente
                                                            _scrollController
                                                                .animateTo(
                                                              _scrollController
                                                                  .position
                                                                  .maxScrollExtent,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              curve: Curves
                                                                  .easeOut,
                                                            );
                                                          });
                                                          return ListView
                                                              .builder(
                                                            controller:
                                                                _scrollController,
                                                            itemCount:
                                                                messages.length,
                                                            shrinkWrap: true,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            physics:
                                                                const AlwaysScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            14,
                                                                        right:
                                                                            14,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Align(
                                                                  alignment: (messages[index]
                                                                              .messageType ==
                                                                          "receiver"
                                                                      ? Alignment
                                                                          .topLeft
                                                                      : Alignment
                                                                          .topRight),
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: (messages[index].messageType ==
                                                                                "receiver"
                                                                            ? Colors.grey.shade200
                                                                            : Colors.blue[200]),
                                                                      ),
                                                                      padding: const EdgeInsets.all(16),
                                                                      child: /*Text(
                                                                      messages[
                                                                              index]
                                                                          .messageContent,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),*/
                                                                          Container(
                                                                        margin: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              messages[index].username,
                                                                              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const SizedBox(height: 4.0),
                                                                            Text(messages[index].messageContent),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        })),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 10),
                                                    height: 60,
                                                    width: double.infinity,
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            //
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .lightBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller: msgCtrl,
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    "Escribe un mensaje",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        FloatingActionButton(
                                                          onPressed: () {
                                                            // Comunicación con el socket
                                                            chatController.sink.add(ChatMessage(
                                                                username:
                                                                    User_instance
                                                                        .instance
                                                                        .nickname,
                                                                messageContent:
                                                                    msgCtrl
                                                                        .text,
                                                                messageType:
                                                                    "receiver"));
                                                            // Enviar mensaje a sala
                                                            SocketSingleton
                                                                .instance
                                                                .enviarMsgChatPartida(
                                                                    msgCtrl
                                                                        .text);

                                                            // Actualizando mis mensajes
                                                            // debería comprobar que ha ido todo bien antes de añadirlo
                                                            messages.add(ChatMessage(
                                                                username:
                                                                    User_instance
                                                                        .instance
                                                                        .nickname,
                                                                messageContent:
                                                                    msgCtrl
                                                                        .text,
                                                                messageType:
                                                                    "sender"));
                                                            // borra el mensaje de la TextBox
                                                            msgCtrl.clear();
                                                          },
                                                          child: Icon(
                                                            Icons.send,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                          backgroundColor:
                                                              Colors.blue,
                                                          elevation: 0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                  );
                                },
                                child: const Text('Chat')))),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          style: GenericButtonSmall,
                          onPressed: () {},
                          child: const Text('Abandonar sala')),
                    ))
                  ])),
              Stack(
                children: [
                  Image.asset(
                    'lib/images/oca_tablero_final.png',
                    width: 400,
                    height: 400,
                  ),
                  if (ficha1 != null)
                    Positioned(child: ficha1, left: leftFicha1, top: topFicha1),
                  if (ficha2 != null)
                    Positioned(child: ficha2, left: leftFicha2, top: topFicha2),
                  if (ficha3 != null)
                    Positioned(child: ficha3, left: leftFicha3, top: topFicha3),
                  if (ficha4 != null)
                    Positioned(child: ficha4, left: leftFicha4, top: topFicha4),
                  if (ficha5 != null)
                    Positioned(child: ficha5, left: leftFicha5, top: topFicha5),
                  if (ficha6 != null)
                    Positioned(child: ficha6, left: leftFicha6, top: topFicha6),
                ],
              ),
              if (userInstance.isMyTurn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        SocketSingleton.instance
                            .jugarTurno(context)
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
                ),
              if (!userInstance.isMyTurn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {},
                      child: SizedBox(
                        height: 50.0, // Ajusta el tamaño como necesites
                        width: 50.0, // Ajusta el tamaño como necesites
                        child: Image.asset(
                            'lib/images/dado_cara_$_diceNumber.png'),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Espaciado entre la imagen y el texto
                    const Text('Espera a tu turno'),
                  ],
                ),
            ],
          ),
        ));
  }

  static void _chatMsgRecevied(String senderName, String msg) {
    chatController.sink.add(ChatMessage(
        username: senderName, messageContent: msg, messageType: "receiver"));
  }
}
