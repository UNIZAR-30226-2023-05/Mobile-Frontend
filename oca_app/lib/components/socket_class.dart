import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/pages/oca_game.dart';
import 'package:oca_app/pages/waiting_room.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:oca_app/components/global_stream_controller.dart';

const url = 'http://192.168.1.46:3000';

typedef ActualizarEstadoCallback = Function();
typedef ActualizarFicha1 = Function(int);
typedef ActualizarFicha2 = Function(int);
typedef ActualizarFicha3 = Function(int);
typedef ActualizarFicha4 = Function(int);
typedef ActualizarFicha5 = Function(int);
typedef ActualizarFicha6 = Function(int);

class SocketSingleton {
  static SocketSingleton? _instance;
  static late IO.Socket socket;
  final GlobalStreamController globalStreamController =
      GlobalStreamController();
  final GlobalStreamController turnController = GlobalStreamController();
  BuildContext? _context;
  ActualizarEstadoCallback? onActualizarEstado;
  ActualizarFicha1? actualizarPosicionFicha1;
  ActualizarFicha2? actualizarPosicionFicha2;
  ActualizarFicha3? actualizarPosicionFicha3;
  ActualizarFicha4? actualizarPosicionFicha4;
  ActualizarFicha3? actualizarPosicionFicha5;
  ActualizarFicha4? actualizarPosicionFicha6;

  late List<String> nombresJugadores;

  factory SocketSingleton() {
    final instance = SocketSingleton.instance
      .._initSocket()
      .._subscribeToEvents();

    return instance;
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  SocketSingleton._internal();

  void dispose() {}

  static SocketSingleton get instance {
    _instance ??= SocketSingleton._internal();
    return _instance!;
  }

  void _initSocket() {
    User_instance userInstance = User_instance.instance;
    String authToken = userInstance.token;
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': authToken}
    });

    void _onPlayerListUpdated(List<dynamic> playerList) {
      // Envía la lista de jugadores al StreamController
      globalStreamController.addData(playerList);
    }

    socket.connect();
    // Registro de eventos

    // Eventos relativos a conexión
    socket.onConnect((data) => {});
    socket.onConnectTimeout((data) => {});
    socket.onConnectError((data) => {});
    socket.onDisconnect((data) => {});

    // Eventos relativos a partida
    /*
    socket.on('estadoPartida', (data) => null);

    socket.on('sigTurno', (data) => null);
    socket.on('finPartida ', (data) => null);
    socket.on("serverRoomMessage", (message) => (print(message)));
    */
  }

  void _subscribeToEvents() {
    User_instance userInstance = User_instance.instance;
    socket.on('updatePlayers', (data) {
      print("updatePlayers: $data");
      if (data is List<dynamic> && data.every((element) => element is String)) {
        // Convierte la lista de Strings en una lista de mapas
        List<Map<String, dynamic>> playerList =
            data.map((playerName) => {'nickname': playerName}).toList();
        globalStreamController.addData(playerList);
      } else {
        print("Error: el formato de la lista de jugadores es incorrecto");
      }

      var value = turnController.playersStreamController.value;
      if (value is List<Map<String, dynamic>>) {
        nombresJugadores =
            value.map((map) => map['nickname'] as String).toList();
        print('Nombres de los jugadores: $nombresJugadores');
      } else {
        print('Error al obtener el número de jugadores');
        // Handle error or set njugadores to a default value
      }
    });
    socket.on('estadoPartida', (data) {
      print("Estado partida");
      print(data);
      List posiciones = data['posiciones'];

      posiciones.forEach((posicion) {
        String nickname = posicion['nickname'];
        int celda = posicion['celda'];

        int index = nombresJugadores.indexOf(
            nickname); // Encuentra la posición del nickname en la lista de nombres de jugadores
        // Llama a la función de actualización correspondiente
        switch (index) {
          case 0:
            actualizarPosicionFicha1!(celda);
            break;
          case 1:
            actualizarPosicionFicha2!(celda);
            break;
          case 2:
            actualizarPosicionFicha3!(celda);
            break;
          case 3:
            actualizarPosicionFicha4!(celda);
            break;
          case 4:
            actualizarPosicionFicha5!(celda);
            break;
          case 5:
            actualizarPosicionFicha6!(celda);
            break;
        }
      });
    });

    socket.on('ordenTurnos', (data) {
      print(data);
      if (_context != null && userInstance.estaEnPartida == false) {
        userInstance.estaEnPartida = true;
        if (data != null &&
            data['ordenTurnos'] != null &&
            data['ordenTurnos'].length > 0) {
          if (data['ordenTurnos'][0] == userInstance.nickname) {
            userInstance.isMyTurn = true;
          } else {
            userInstance.isMyTurn = false;
          }
        }
        Navigator.of(_context!)
            .push(MaterialPageRoute(builder: (context) => Oca_game()));
      } else {
        //gestion de los turnos
        if (data != null &&
            data['ordenTurnos'] != null &&
            data['ordenTurnos'].length > 0) {
          if (data['ordenTurnos'][0] == userInstance.nickname) {
            userInstance.isMyTurn = true;
          } else {
            userInstance.isMyTurn = false;
          }
        }
      }
    });
    socket.on('sigTurno', (data) {
      print(data);
      if (data['turno'] == User_instance.instance.nickname) {
        User_instance.instance.isMyTurn = true;
      } else {
        User_instance.instance.isMyTurn = false;
      }

      // Llama a la función actualizarEstado de Oca_game
      onActualizarEstado?.call();
    });

    socket.on('finPartida', (data) => ("finPartida: $data"));
    socket.on(
        "serverRoomMessage", (message) => ("ServerRoomMessage: $message"));
    socket.on("destroyingRoom",
        (message) => (print("respuesta del destroying $message")));
  }

  // -------- EVENTOS DE SALA --------

  // Creación de sala
  // response: {id: int, message: "...", status: [ok,error]}
  Future<int> createRoom(String roomName, int nPlayers) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    if (response['status'] == 'ok') {
      print("createRoom correcto");
      // Actualizar información sobre sala
      User_instance.instance.idRoom = response['id'];
      User_instance.instance.soyLider = true;
    } else {
      print("Error: ${response['message']}");
      // Falta manejar el error, puede ser mostrar un pop-up por pantalla
    }
    print(response);
    return response['id'];
  }

  // Unirse a sala
  // repsonse: {message: "...", players: [p1 , p2, ...], status: [ok,error]}
  Future<String> joinRoom(int idRoom) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};
    // Map<String, dynamic> miJson = {'nickname': 'c'};

    socket.emitWithAck('joinRoom', [idRoom, miJson], ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    if (response['status'] == 'ok') {
      // Ha ido bien
      print("joinRoom correcto");
      // Actualizar información sobre sala
      User_instance.instance.idRoom = idRoom;
      User_instance.instance.soyLider = false;
    } else {
      print("Error: ${response['message']}");
      // Falta manejar el error, puede ser mostrar un pop-up por pantalla
    }
    print(response);

    return response['roomName'];
  }

  // Salir de una sala
  // {message: "..." players: [p1, ...], status: [ok|error]}
  Future<void> leaveRoom() async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    socket.emitWithAck('leaveTheRoom', [User_instance.instance.idRoom],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    if (response['status'] == 'ok') {
      // Ha ido bien
      print("leaveRoom correcto");
      // Actualizar información sobre sala
      User_instance.instance.idRoom = -1;
      User_instance.instance.soyLider = false;
    } else {
      print("Error: ${response['message']}");
      // Falta manejar el error, puede ser mostrar un pop-up por pantalla
    }
    print(response);
  }

  // Destruir sala: todos los jugadores son expulsados de la sala
  // (disponible para lider)
  Future<void> destroyRoom() async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    if (User_instance.instance.soyLider) {
      socket.emitWithAck('destroyRoom', [User_instance.instance.idRoom],
          ack: (response) {
        completer.complete(response);
      });
    } else {
      // No es lider, notificar con un mensaje o algo
    }

    response = await completer.future;
    if (response['status'] == 'ok') {
      // Ha ido bien
      print("destroyRoom correcto");
      // Actualizar información sobre sala
      User_instance.instance.idRoom = -1;
      User_instance.instance.soyLider = false;
    } else {
      print("Error: ${response['message']}");
      // Falta manejar el error, puede ser mostrar un pop-up por pantalla
    }
    print(response);
  }

  // Expulsar jugador de sala (disponible para lider)
  Future<void> removePlayerFromRoom(String playerNameToRemove) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor
    Map<String, dynamic> miJson = {'nickname': playerNameToRemove};

    socket.emitWithAck(
        'removePlayerFromRoom', [User_instance.instance.idRoom, miJson],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);

    // Si ha ido bien, entonces
  }

  // -------- EVENTOS DE PARTIDA --------

  // Empezar partida
  Future<bool> empezarPartida(int turnTimeout) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    socket.emitWithAck(
        'startGame', [User_instance.instance.idRoom, turnTimeout.toString()],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;

    if (response['status'] == 'ok') {
      print("Partida iniciada: ${response['message']}");
      return true;
    } else {
      print("Error al iniciar partida: ${response['message']}");
      return false;
      // Aquí puedes manejar el error, por ejemplo, mostrando un pop-up en la pantalla
    }
  }

  // Jugar turno
  Future<Map<String, dynamic>> jugarTurno(context) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response;

    socket.emitWithAck('turn', [User_instance.instance.idRoom],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);

    // Si el mensaje es "Estás penalizado" y el estado es "error", no hagas nada
    if (response['message'] == 'Estás penalizado' &&
        response['status'] == 'error') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Estas penalizado'),
            content: Text(
                'Has caido en una casilla de penalizacion, asi que no puedes jugar este turno'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      return {}; // Retorna un mapa vacío
    }

    if (response['message'] == 'Has ganado' && response['status'] == 'ok') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enhorabuena, has ganado la partida!'),
            content: Text('Has ganado, ahora volveras al menú principal'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(_context!).push(MaterialPageRoute(
                      builder: (context) => Main_Menu_Page()));
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      return {}; // Retorna un mapa vacío
    }

    if (response['res']['rollAgain'] == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Te toca volver a tirar'),
            content: Text(
                'Enhorabuena, has caido en la casilla ${response['res']['afterDice']}, asi que te mueves a la casilla ${response['res']['finalCell']} y vuelves a tirar'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
    }

    // Devuelve el campo 'res'
    return response['res'];
  }
}
