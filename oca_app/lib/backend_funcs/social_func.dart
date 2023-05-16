import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oca_app/backend_funcs/url.dart';

const baseUrl = url;

const String baseUrl = 'http://192.168.1.51:3000';

Future<bool> enviarSolicitudAmistad(
    int id_usuario_envia, int id_usuario_recibe) async {
  print("Enviando datos");
  const url = '$baseUrl/social/friends/';
  final body = {
    "id_usuario_envia": id_usuario_envia,
    "id_usuario_recibe": id_usuario_recibe
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
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
        "\n" +
        id_usuario_envia.toString() +
        "\n" +
        id_usuario_recibe.toString());
    return false;
  }
}

Future<List<Map<String, dynamic>>> solicitudesPendientes(int id_usuario) async {
  print("Enviando datos");
  var url = '$baseUrl/social/friends/' + id_usuario.toString();

  final response = await http.put(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  final respJson = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("Solicitud exitosa");
    print(respJson);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> listaAux = jsonResponse['solicitudes'];

    if (listaAux.isEmpty) {
      return [];
    } else {
      List<Map<String, dynamic>> solicitudes = listaAux.map((element) {
        return {
          'nickname': element['usuario_solicitud_id_usuario_enviaTousuario']
              ['nickname'] as String,
          'tipo': 'solicitud', // Agrega esta línea
        };
      }).toList();
      return solicitudes;
    }
  } else {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("Error en la solicitud " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.body +
        "\n" +
        id_usuario.toString());
    return [];
  }
}

Future<List<Map<String, dynamic>>> listaAmigos(int id_usuario) async {
  print("Enviando datos");
  var url =
      'http://169.51.206.12:32021/social/friends/' + id_usuario.toString();

  final response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  final respJson = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("Solicitud exitosa");
    print(respJson);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> listaAux = jsonResponse['amigos'] ?? [];

    if (listaAux.isEmpty) {
      return [];
    } else {
      List<Map<String, dynamic>> amigos = listaAux.map((element) {
        return {
          'nickname': element as String,
          'tipo': 'amigo', // Agrega esta línea
        };
      }).toList();
      return amigos;
    }
  } else {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("Error en la solicitud " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.body +
        "\n" +
        id_usuario.toString());
    return [];
  }
}

Future<bool> rechazarSolcitudAmistad(
    int id_usuario_envia, int id_usuario_recibe) async {
  print("Enviando datos");
  const url = '$baseUrl/social/friends';
  final body = {
    "id_usuario_envia": id_usuario_recibe,
    "id_usuario_recibe": id_usuario_envia
  };

  final response = await http.delete(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
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
        "\n" +
        id_usuario_envia.toString() +
        "\n" +
        id_usuario_recibe.toString());
    return false;
  }
}
