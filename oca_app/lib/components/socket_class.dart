import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/pages/waiting_room.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const url = 'http://192.168.1.51:3000';

class SocketSingleton {
  static SocketSingleton? _instance;
  static late IO.Socket socket;
  // Utilizado para conexión con WaitingRoom
  GlobalKey<State<WaitingRoom>>? myKey;
  WaitingRoom? myWidget;

  factory SocketSingleton() {
    return instance.._initSocket();
  }

  SocketSingleton._internal();

  void dispose() {}

  static SocketSingleton get instance {
    _instance ??= SocketSingleton._internal();
    return _instance!;
  }

// método init para crear el GlobalKey y el widget asociado
  void init() {
    myKey = GlobalKey<State<WaitingRoom>>();
    myWidget = WaitingRoom(key: myKey!);
  }

  void _initSocket() {
    User_instance userInstance = User_instance.instance;
    String authToken = userInstance.token;
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': authToken}
    });

    socket.connect();
    // Registro de eventos

    // Eventos relativos a conexión
    socket.onConnect((data) => {});
    socket.onConnectTimeout((data) => {});
    socket.onConnectError((data) => {});
    socket.onDisconnect((data) => {});

    // Eventos relativos a partida
    socket.on('estadoPartida', (data) => null);
    socket.on('ordenTurnos', (data) => null);
    socket.on('sigTurno', (data) => null);
    socket.on('finPartida ', (data) => null);
  }

  // -------- EVENTOS DE SALA --------

  // Creación de sala
  Future<int> createRoom(String roomName, int nPlayers) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
    return response['id'];
  }

  // Unirse a sala
  Future<void> joinRoom(int idRoom) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};
    // Map<String, dynamic> miJson = {'nickname': 'c'};

    socket.emitWithAck('joinRoom', [idRoom, miJson], ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }

  // Salir de una sala
  Future<void> leaveRoom() async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    socket.emitWithAck('leaveTheRoom', [User_instance.instance.idRoom],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }

  // Destruir sala: todos los jugadores son expulsados de la sala
  // (disponible para lider)
  Future<void> destroyRoom() async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    socket.emitWithAck('destroyRoom', [User_instance.instance.idRoom],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }

  // Expulsar jugador de sala (disponible para lider)
  Future<void> removePlayerFromRoom(String playerNameToRemove) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor0

    socket.emitWithAck('removePlayerFromRoom',
        [User_instance.instance.idRoom, playerNameToRemove], ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }

  // -------- EVENTOS DE PARTIDA --------

  // Empezar partida
  Future<void> empezarPartida(int turnTimeout) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor0

    socket
        .emitWithAck('startGame', [User_instance.instance.idRoom, turnTimeout],
            ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }

  // Jugar turno
  Future<void> jugarTurno() async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor0

    socket.emitWithAck('turn', [User_instance.instance.idRoom],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }
}
