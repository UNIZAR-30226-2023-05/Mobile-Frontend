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

/*
Todo el código que aparece a continuación es un programa sencillo que 
muestra una pantalla con un botón que crea un instancia de un socket
e intenta conectarse al servidor.
Prueba en la dirección con los dos. Por problemas con el emulador, en foros
y demás han propuesto como solución porque el emulador no reconce la IP:
  'http://localhost:3000'
  'http://10.0.2.2:3000'
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socket.IO Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocketIOClient(),
    );
  }
}

class SocketIOClient extends StatefulWidget {
  @override
  _SocketIOClientState createState() => _SocketIOClientState();
}

class _SocketIOClientState extends State<SocketIOClient> {
  IO.Socket? socket;

  void connectToServer() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': 'token=your_auth_token_here'
    });
    print("connectToServer()...");

    // Manejo de eventos del socket
    socket?.onConnect((data) => print("Conectado: $data"));
    socket?.onConnectError((data) => print("Error conection: $data"));
    socket?.onConnectTimeout((data) => print("Timeout: $data"));
    socket?.onDisconnect((data) => print("Desconectado: $data"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket.IO Client'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Conectar al servidor local'),
          onPressed: () {
            setState(() {
              connectToServer();
            });
          },
        ),
      ),
    );
  }
}


// EL CÓDIGO A PARTIR DE AQUÍ HACIA ABAJO,  !!! NO TOCAR ¡¡¡

/*
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateLobby(),
    );
  }
}
*/

