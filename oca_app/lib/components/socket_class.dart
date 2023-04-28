import 'package:flutter/material.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/pages/join_lobby.dart';
import 'package:oca_app/pages/create_lobby.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketSingleton {
  static final SocketSingleton _singleton = SocketSingleton._internal();
  static late IO.Socket socket;

  factory SocketSingleton() {
    print("dentro de factory");
    return _singleton.._initSocket();
  }

  SocketSingleton._internal();

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

  void crearSala() {
    Map<String, dynamic> miJson = {'nickname': 'pepe'};
    String miJsonString = json.encode(miJson);

    socket.emitWithAck('createRoom', [miJson, 'misala2', 3, 'clasicc'],
        ack: (data) {
      print('Respuesta recibida: $data');
    });
  }
}
