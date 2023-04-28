import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> enviarSolicitudAmistad(
    int id_usuario_envia, int id_usuario_recibe) async {
  print("Enviando datos");
  const url = 'https://backendps.vercel.app/social/friends';
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

Future<List<String>> solicitudesPendientes(int id_usuario) async {
  print("Enviando datos");
  var url =
      'https://backendps.vercel.app/social/friends/' + id_usuario.toString();

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
      List<String> solicitudes = listaAux
          .map((element) =>
              element['usuario_solicitud_id_usuario_enviaTousuario'] != null
                  ? element['usuario_solicitud_id_usuario_enviaTousuario']
                      ['nickname'] as String
                  : '')
          .toList();
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
