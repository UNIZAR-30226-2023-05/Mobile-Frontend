import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      final String token = jsonResponse['token'];
      print(token);

      const storage = FlutterSecureStorage();
      await storage.write(key: 'authToken', value: token);

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
