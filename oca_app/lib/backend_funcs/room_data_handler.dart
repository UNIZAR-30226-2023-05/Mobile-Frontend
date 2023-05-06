//import 'package:socket_io_client/socket_io_client.dart' as IO; // socket.io

class RoomDataHandler {
  static late int idRoom; // id de la sala creada ¿o a la que se va a unir?
  static late int nPlayers; // número de jugadores
  static late String roomName; // IGUAL NO ES NECESARIO

  // Constructor
  RoomDataHandler(int _idRoom, int _nPlayers) {
    idRoom = _idRoom;
    nPlayers = _nPlayers;
  }

  // Setters y getters
}
