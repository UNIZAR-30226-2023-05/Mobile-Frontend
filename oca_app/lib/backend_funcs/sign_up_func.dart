import 'dart:convert';
import 'package:http/http.dart' as http;


class Registro {
  late String nickname;
  late String email;
  late String password;

  Registro(String nickname, String email, String password) {
    this.nickname = nickname;
    this.email = email;
    this.password = password;
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'email': email,
      'password': password,
    };
  }

  Future<void> enviar() async {
    const url = 'https://mi-servidor.com/api/registro';
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(toJson());

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      print("Registro exitoso");
      // Registro exitoso
    } else {
      print("Error en el registro");
      // Error en el registro
    }
  }

   Future<void> mostrarResultados() async {
    print("Va bien");
   }
}
