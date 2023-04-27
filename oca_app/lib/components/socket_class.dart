import 'package:flutter/material.dart';
import 'package:oca_app/pages/join_lobby.dart';
import 'package:oca_app/pages/create_lobby.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketSingleton {
  static final SocketSingleton _singleton = SocketSingleton._internal();
  static late final IO.Socket socket;

  factory SocketSingleton(String token) {
    print("dentro de factory");
    return _singleton.._initSocket(token);
  }

  SocketSingleton._internal();

  void _initSocket(String token) {
    print("dentro de initSocket()");
    print("el socket es " + token);
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Authorization': 'Bearer $token'}
    });
    socket.connect();
    // Definir los handlers de eventos aquí
    socket.onConnect((data) => print("conectado $data"));
    socket.onConnectTimeout((data) => print("timeout $data"));
    socket.onConnectError((data) => print("Error: $data"));
    socket.onDisconnect((data) => print("desconectado $data"));
    Future.delayed(Duration(seconds: 30), () {
      // Hacer algo después de 5 segundos
      print(socket.connected);
    });
  }
}
