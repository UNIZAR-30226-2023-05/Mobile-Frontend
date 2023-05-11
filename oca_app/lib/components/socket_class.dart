import 'dart:async';
import 'package:oca_app/components/User_instance.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:oca_app/components/global_stream_controller.dart';

const url = 'http://192.168.1.51:3000';

class SocketSingleton {
  static SocketSingleton? _instance;
  static late IO.Socket socket;
  final GlobalStreamController globalStreamController =
      GlobalStreamController();

  factory SocketSingleton() {
    final instance = SocketSingleton.instance
      .._initSocket()
      .._subscribeToEvents();

    return instance;
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
      globalStreamController.addPlayersData(playerList);
    }

    socket.connect();
    // Registro de eventos

    // Eventos relativos a conexión
    socket.onConnect((data) => {});
    socket.onConnectTimeout((data) => {});
    socket.onConnectError((data) => {});
    socket.onDisconnect((data) => {});

    // Eventos relativos a partida
    socket.on('updatePlayers', (data) {
      print("updatePlayers: $data");
      globalStreamController.addPlayersData(data);
    });
    socket.on('estadoPartida', (data) => null);
    socket.on('ordenTurnos', (data) => print(data));
    socket.on('sigTurno', (data) => null);
    socket.on('finPartida ', (data) => null);
    socket.on("serverRoomMessage",
        (message) => (print("respuesta del server:" + message)));
  }

  void _subscribeToEvents() {
    socket.on('updatePlayers', (data) {
      print("updatePlayers: $data");
      if (data is List<dynamic> && data.every((element) => element is String)) {
        // Convierte la lista de Strings en una lista de mapas
        List<Map<String, dynamic>> playerList =
            data.map((playerName) => {'nickname': playerName}).toList();
        globalStreamController.addPlayersData(playerList);
      } else {
        print("Error: el formato de la lista de jugadores es incorrecto");
      }
    });
    socket.on('estadoPartida', (data) => null);
    socket.on('ordenTurnos', (data) => print(data));
    socket.on('sigTurno', (data) => null);
    socket.on('finPartida ', (data) => null);
    socket.on("serverRoomMessage",
        (message) => (print("respuesta del server" + message)));
    socket.on("destroyingRoom",
        (message) => (print("respuesta del destroying $message")));
  }

  // -------- EVENTOS DE SALA --------

  // Creación de sala
  // response: {id: int, message: "...", status: [ok,error]}
  Future<Map<String, dynamic>> createRoom(String roomName, int nPlayers) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor
    late Map<String, dynamic> returnVal;

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};

    socket.emitWithAck('createRoom', [miJson, roomName, nPlayers, 'clasicc'],
        ack: (response) {
      completer.complete(response);
    });

    // Espera hasta que llega respuesta...
    response = await completer.future;

    if (response['status'] == 'ok') {
      // Actualización de datos de sala
      User_instance.instance.idRoom = response['id'];
      User_instance.instance.soyLider = true;

      // Valor de retorno
      returnVal = {
        'status': true,
        'id': response['id'],
      };
    } else {
      // Valor de retorno con mensaje de error genérico
      returnVal = {
        'status': false,
        'id': response['id'],
        'msgError': "Error al crear la sala. \n Inténtelo más tarde."
      };
    }

    return returnVal;
  }

  // Unirse a sala
  // repsonse: {message: "...", players: [p1 , p2, ...], status: [ok,error]}
  Future<Map<String, dynamic>> joinRoom(int idRoom) async {
    final completer = Completer<Map<String, dynamic>>();
    late Map<String, dynamic> response; // guarda respuesta del servidor
    late Map<String, dynamic> returnVal;

    Map<String, dynamic> miJson = {'nickname': User_instance.instance.nickname};
    // Map<String, dynamic> miJson = {'nickname': 'c'};

    socket.emitWithAck('joinRoom', [idRoom, miJson], ack: (response) {
      completer.complete(response);
    });

    response = await completer.future;
    if (response['status'] == 'ok') {
      // Actualizar información sobre sala
      User_instance.instance.idRoom = idRoom;
      User_instance.instance.soyLider = false;
      returnVal = {
        'status': true,
        'id': response['id'],
      };
    } else {
      returnVal = {
        'status': true,
        'id': response['id'],
        'msgError': "Error al unirse a la sala.\n Inténtelo de nuevo más tarde."
      };
    }

    return returnVal;
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
