import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oca_app/components/User_instance.dart';

class Registro {
  late String nickname;
  late String email;
  late String password;

  Registro(String nickname, String email, String password) {
    this.nickname = nickname;
    this.email = email;
    this.password = password;
  }

  Future<bool> enviar() async {
    print("Enviando datos");
    const url = 'https://backendps.vercel.app/users/register';
    final body = {"nickname": nickname, "email": email, "password": password};

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
