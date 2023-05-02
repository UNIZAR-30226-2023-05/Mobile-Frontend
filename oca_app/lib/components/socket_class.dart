import 'dart:async';

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
    // en eina: http://10.1.49.205:3000
    // en casa: http://192.168.1.51:3000
    socket = IO.io('http://10.1.49.205:3000', <String, dynamic>{
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

  Future<int> createRoom(String roomName, int nPlayers) async {
    final completer = Completer<dynamic>();
    //final completer = Completer<Map<String, dynamic>>(); // para guardar todo el JSON

    // Handler del callback
    void myCallback(Map<String, dynamic> response) {
      final int id = response['id'];
      completer.complete(id);
    }

    User_instance ui = User_instance.instance;
    // Map<String, dynamic> miJson = {'nickname': '${ui.nickname}'};
    Map<String, dynamic> miJson = {'nickname': 'f'};
    String miJsonString = json.encode(miJson);

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: myCallback);

    // Hasta que no haya inicializado el campo no se resulve, y se hace
    // cuando el servidor ha manadado la respuesta
    final int id = await completer.future;
    print("id = $id");
    // Accede a los campos de la respuesta
    //print('campo1: ${respuesta['campo1']}');
    //print('campo2: ${respuesta['campo2']}');
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
