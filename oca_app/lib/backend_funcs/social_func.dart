import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SolicitudAmistad {
  late String id_usuario_envia;
  late String id_usuario_recibe;

  SolicitudAmistad(String id_usuario_envia, String id_usuario_recibe) {
    this.id_usuario_envia = id_usuario_envia;
    this.id_usuario_recibe = id_usuario_recibe;
  }

  Future<bool> enviar() async {
    print("Enviando datos");
    const url = 'https://backendps.vercel.app/social/friends';
    final body = {
      "id_usuario_envia": id_usuario_envia,
      "id_usuario_recibe": id_usuario_recibe
    };

    final response = await http.post(Uri.parse(url), headers: null, body: body);

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
          "\n" +
          id_usuario_envia +
          "\n" +
          id_usuario_recibe);
      return false;
    }
  }
}
