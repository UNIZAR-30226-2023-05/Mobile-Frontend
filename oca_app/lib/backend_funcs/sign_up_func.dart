import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oca_app/components/User_instance.dart';

const String baseUrl = 'http://10.1.63.32:3000';
// const String baseUrl = 'http://192.168.1.51:3000';
// const String baseUrl = 'https://backendps.vercel.app';

class Registro {
  late String _nickname;
  late String _email;
  late String _password;

  Registro(String nickname, String email, String password) {
    _nickname = nickname;
    _email = email;
    _password = password;
  }

  Future<bool> enviar() async {
    print("Enviando datos");

    const url = '$baseUrl/users/register';
    final body = {
      "nickname": _nickname,
      "email": _email,
      "password": _password
    };

    final response = await http.post(Uri.parse(url), headers: null, body: body);

    if (response.statusCode == 201) {
      print("Registro exitoso");

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      /*
      final String token = jsonResponse['token'];
      print(token);

      User_instance user_instance = User_instance.instance;
      user_instance.token = token;
      */
      // Registro exitoso
      return true;
    } else {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Error en el registro " +
          response.statusCode.toString() +
          "\n" +
          "\n" +
          response.body);
      return false;
      // Error en el registro
    }
  }
}
