import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class user {
  late String email;
  late int user_id;

  SolicitudAmistad(String email_user) {
    this.email = email_user;
  }

  Future<bool> get_id() async {
    print("Enviando datos");
    var url = 'https://backendps.vercel.app/users/register/:' + email;

    final response = await http.get(
      Uri.parse(url),
      headers: null,
    );

    if (response.statusCode == 200) {
      print("Solicitud exitosa");
      return true;
    } else {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Error en la solicitud " +
          response.statusCode.toString() +
          "\n" +
          "\n" +
          response.body +
          "\n");
      return false;
    }
  }
}
