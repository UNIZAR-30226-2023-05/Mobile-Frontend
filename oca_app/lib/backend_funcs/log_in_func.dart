import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/socket_class.dart';

class LogIn {
  late String email;
  late String password;

  LogIn(String email, String password) {
    this.email = email;
    this.password = password;
  }

  Future<bool> enviar() async {
    print("Enviando datos");
    const url = 'https://backendps.vercel.app/users/login';
    final body = {"email": email, "password": password};

    final response = await http.post(Uri.parse(url), headers: null, body: body);

    if (response.statusCode == 200) {
      print("Login exitoso");

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final String token = jsonResponse['token'];
      print(token);

      User_instance user_instance = User_instance.instance;
      user_instance.token = token;

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
