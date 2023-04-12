import 'package:http/http.dart' as http;

class HandleLobbyData {
  late String lobbyName;
  late String numPlayers;

  // Usado cuando un jugador crea una sala
  HandleCreateLobby(String lobbyName, String numPlayers) {
    this.lobbyName = lobbyName;
    this.numPlayers = numPlayers;
  }

  // Usado cuando un jugador se une a una partida
  HandleJoinLobby(String lobbyName) {
    this.lobbyName = lobbyName;
  }

/*
  Future<void> enviar() async {
    print("Enviando datos");
    const url = 'https://backendps.vercel.app/users/login';
    final body = {"email": email, "password": password};

    final response = await http.post(Uri.parse(url), headers: null, body: body);

    if (response.statusCode == 201) {
      print("Login exitoso");
    } else {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Error en el Login " +
          response.statusCode.toString() +
          "\n" +
          "\n" +
          response.body);
    }
  }
  */
}
