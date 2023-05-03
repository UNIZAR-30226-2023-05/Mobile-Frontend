import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketSingleton {
  static SocketSingleton? _instance;
  static late IO.Socket socket;

  factory SocketSingleton() {
    return instance.._initSocket();
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
    // en casa: http://192.168.1.51:3000
    socket = IO.io('http://10.1.63.32:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': '$authToken'}
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

  Future<int> createRoom(String roomName, int nPlayers) async {
    // Se utiliza para esperar respuesta del servidor, necesario
    // porque emitWithAck es un procedimiento
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};
    // Map<String, dynamic> miJson = {'nickname': 'a'};

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
    return response['id'];
  }

  // -1 si no puede unirse a la sala
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

  // Falta: Manejar el mensaje de salida
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

  // Disponible sólo para el creador de la sala
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

  // Disponible sólo para el creador de la sala
  Future<void> removePlayerFromRoom(String playerNameToRemove) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor0

    socket.emitWithAck('removePlayerFromRoom', [1, 'JuanCarlosChupapijas'],
        ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    print(response);
  }
}
