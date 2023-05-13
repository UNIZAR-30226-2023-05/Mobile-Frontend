import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/pages/oca_game.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:oca_app/components/global_stream_controller.dart';

const url = 'http://192.168.1.51:3000';

typedef ActualizarEstadoCallback = Function();
typedef ActualizarFicha1 = Function(int);
typedef ActualizarFicha2 = Function(int);
typedef ActualizarFicha3 = Function(int);
typedef ActualizarFicha4 = Function(int);
typedef ActualizarFicha5 = Function(int);
typedef ActualizarFicha6 = Function(int);

class SocketSingleton {
  // Atributos
  static SocketSingleton? _instance;
  static late IO.Socket socket;
  // Stream de salas
  final GlobalStreamController globalStreamController =
      GlobalStreamController();
  // Stream de partidas
  final GlobalStreamController turnController = GlobalStreamController();
  // Contexto
  BuildContext? _context;
  // Control de estado de posiciones de fichas
  ActualizarEstadoCallback? onActualizarEstado;
  ActualizarFicha1? actualizarPosicionFicha1;
  ActualizarFicha2? actualizarPosicionFicha2;
  ActualizarFicha3? actualizarPosicionFicha3;
  ActualizarFicha4? actualizarPosicionFicha4;
  ActualizarFicha3? actualizarPosicionFicha5;
  ActualizarFicha4? actualizarPosicionFicha6;

  late List<String> nombresJugadores;

  // Constructor especial de retorno de instancias
  factory SocketSingleton() {
    final instance = SocketSingleton.instance
      .._initSocket()
      .._subscribeToEvents();

    return instance;
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  // Constructor privado
  SocketSingleton._internal();

  // Getter instancia de clase
  static SocketSingleton get instance {
    _instance ??= SocketSingleton._internal();
    return _instance!;
  }

  // Inicialización de socket
  void _initSocket() {
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': User_instance.instance.token}
    });

    // void _onPlayerListUpdated(List<dynamic> playerList) {
    //   // Envía la lista de jugadores al StreamController
    //   globalStreamController.addData(playerList);
    // }

    // Conexión manual
    socket.connect();
    // Suscripción a eventos
    _subscribeToEvents();
  }

  void _subscribeToEvents() {
    final ui = User_instance.instance; // Simplificación para referencias
    // ---- Eventos de conexión ----

    socket.onConnect((data) => {print("onConnect: $data")});
    socket.onConnectTimeout((data) => {print("onConnectTimeout: $data")});
    socket.onConnectError((data) => {print("onConnectError: $data")});
    socket.onDisconnect((data) => {print("onDisconnect: $data")});

    // ---- Eventos de sala ----

    // Update players: usado para controlar jugadores en la sala de espera
    socket.on('updatePlayers', (data) {
      print("updatePlayers: $data");

      // Check tipo recibido correcto y envío JSON de
      // jugadores por stream de partida
      if (data is List<String>) {
        List<Map<String, dynamic>> playerList =
            data.map((playerName) => {'nickname': playerName}).toList();
        globalStreamController.addData(playerList);
      } else {
        print("Error: el formato de la lista de jugadores es incorrecto");
      }

      // Exception si value aún no se ha enviado un dato por Stream turnController
      try {
        // Lee el último dato emitido
        var value = turnController.playersStreamController.value;

        // Check tipo correcto y conversión a JSON para usar fácilmente
        if (value is List<Map<String, dynamic>>) {
          nombresJugadores =
              value.map((map) => map['nickname'] as String).toList();
          print('Nombres de los jugadores: $nombresJugadores');
        } else {
          print('Error al obtener el número de jugadores');
          // Handle error or set njugadores to a default value
        }
      } catch (e) {
        print(e);
      }
    });

    // ---- Eventos de partida ----
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
      if (_context != null && ui.estaEnPartida == false) {
        ui.estaEnPartida = true;
        if (data != null &&
            data['ordenTurnos'] != null &&
            data['ordenTurnos'].length > 0) {
          if (data['ordenTurnos'][0] == ui.nickname) {
            ui.isMyTurn = true;
          } else {
            ui.isMyTurn = false;
          }
        }
        Navigator.of(_context!)
            .push(MaterialPageRoute(builder: (context) => Oca_game()));
      } else {
        //gestion de los turnos
        if (data != null &&
            data['ordenTurnos'] != null &&
            data['ordenTurnos'].length > 0) {
          if (data['ordenTurnos'][0] == ui.nickname) {
            ui.isMyTurn = true;
          } else {
            ui.isMyTurn = false;
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
  Future<Map<String, dynamic>> createRoom(String roomName, int nPlayers) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor
    late Map<String, dynamic> retVal;

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
      retVal = {'status': true, 'idRoom': response['id']};
    } else {
      retVal = {
        'status': false,
        'errorMsg':
            "Ha habido un error al crear la sala. \n Inténtelo de nuevo más tarde"
      };
    }
    print(response);

    return retVal;
  }

  // Unirse a sala
  // repsonse: {message: "...", players: [p1 , p2, ...], status: [ok,error]}
  Future<Map<String, dynamic>> joinRoom(int idRoom) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor
    late Map<String, dynamic> retVal;

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};

    socket.emitWithAck('joinRoom', [idRoom, miJson], ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    if (response['status'] == 'ok') {
      // Actualizar información sobre sala
      User_instance.instance.idRoom = idRoom;
      User_instance.instance.soyLider = false;
      retVal = {'status': true, 'roomName': response['roomName']};
    } else {
      retVal = {
        'status': false,
        'errorMsg':
            "Ha habido un error al unirse a la sala. \n Inténtelo de nuevo más tarde"
      };
    }
    print(response);

    return retVal;
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
