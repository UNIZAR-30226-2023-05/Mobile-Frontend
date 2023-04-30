import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/pages/join_room.dart';
import 'package:oca_app/pages/create_room.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketSingleton {
  static final SocketSingleton _instance = SocketSingleton._internal();
  static late final IO.Socket socket;

  factory SocketSingleton() {
    return instance.._initSocket();
  }

  SocketSingleton._internal();

  static SocketSingleton get instance {
    return _instance;
  }

  void _initSocket() {
    User_instance user_instance = User_instance.instance;
    String authToken = user_instance.token;

    socket = IO.io('http://192.168.1.51:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': '$authToken'}
    });

    socket.connect();
    socket.onConnect((data) => print("conectado $data"));
    socket.onConnectTimeout((data) => print("timeout $data"));
    socket.onConnectError((data) => print("Error: $data"));
    socket.onDisconnect((data) => print("desconectado $data"));
  }

  int createRoom(String roomName, int nPlayers) {
    User_instance ui = User_instance.instance;
    // Map<String, dynamic> miJson = {'nickname': '${ui.nickname}'};
    Map<String, dynamic> miJson = {'nickname': 'jc'};
    String miJsonString = json.encode(miJson);

    int id = -1; // idRooms

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: (data) {
      // Convertir el objeto JSON a map
      Map<String, dynamic> response = Map<String, dynamic>.from(data);
      print(response);
      // Check error
      if (response['status'] != "ok") {
        throw FlutterError(response['message']);
        // el código termina con el error
      }

      id = int.parse(response['id']);
    });

    return id;
  }

  void joinRoom(int idRoom) {
    User_instance ui = User_instance.instance;
    Map<String, dynamic> miJson = {'nickname': 'joselu'};
    String miJsonString = json.encode(miJson);

    socket.emitWithAck('joinRoom', [idRoom, miJson], ack: (data) {
      // Convertir el objeto JSON a map
      Map<String, dynamic> response = Map<String, dynamic>.from(data);
      print(response);

      // Check error
      if (response['status'] != "ok") {
        throw FlutterError(response['message']);
        // el código termina con el error
      }
    });
  }

  // Falta: Manejar el mensaje de salida
  void leaveRoom() {
    User_instance ui = User_instance.instance;
    Map<String, dynamic> miJson = {'nickname': '${ui.nickname}'};
    String miJsonString = json.encode(miJson);

    socket.emitWithAck('leaveTheRoom', [ui.idRoom, miJson], ack: (data) {
      // Convertir el objeto JSON a map
      Map<String, dynamic> response = Map<String, dynamic>.from(data);

      // Check error
      if (response['status'] != "ok") {
        throw FlutterError(response['message']);
        // el código termina con el error
      }

      // Manejar mensaje de salida
    });
  }

  // Disponible sólo para el creador de la sala
  void destroyRoom() {
    User_instance ui = User_instance.instance;
    Map<String, dynamic> miJson = {'nickname': '${ui.nickname}'};
    String miJsonString = json.encode(miJson);

    socket.emitWithAck('destroyRoom', [ui.idRoom, miJson], ack: (data) {
      // Convertir el objeto JSON a map
      Map<String, dynamic> response = Map<String, dynamic>.from(data);

      // Check error
      if (response['status'] != "ok") {
        throw FlutterError(response['message']);
        // el código termina con el error
      }
    });
  }

  // Disponible sólo para el creador de la sala
  void removePlayerFromRoom(String playerNameToRemove) {
    User_instance ui = User_instance.instance;

    socket.emitWithAck('removePlayerFromRoom', [ui.idRoom, playerNameToRemove],
        ack: (data) {
      // Convertir el objeto JSON a map
      Map<String, dynamic> response = Map<String, dynamic>.from(data);

      // Check error
      if (response['status'] != "ok") {
        throw FlutterError(response['message']);
        // el código termina con el error
      }
    });
  }
}
