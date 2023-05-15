import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/socket_class.dart';

// const baseUrl = 'http://169.51.206.12:32021';
const baseUrl = 'http://192.168.1.51:3000';

class LogIn {
  late String _email;
  late String _password;

  LogIn(String email, String password) {
    _email = email;
    _password = password;
  }

  Future<bool> enviar() async {
    print("Enviando datos");

    const url = '$baseUrl/users/login';
    final body = {"email": _email, "password": _password};

    final response = await http.post(Uri.parse(url), headers: null, body: body);

    if (response.statusCode == 200) {
      print("Login exitoso");

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final String token = jsonResponse['token'];
      print(token);

      User_instance.instance.token = token;

      SocketSingleton(); // inicializar el socket al logearse

      return true;
    } else {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Error en el Login " +
          response.statusCode.toString() +
          "\n" +
          "\n" +
          response.body);
      return false;
    }
  }
}
