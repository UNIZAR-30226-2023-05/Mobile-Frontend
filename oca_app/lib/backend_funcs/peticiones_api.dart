import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:oca_app/components/User_instance.dart';

const String baseUrl = 'http://192.168.1.51:3000';

class ApiService {
  //FUNCION GENERICA PARA USAR EL TOKEN, PUEDES AGREGAR MAS FUNCIONES
  Future<http.Response> getData(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get('$baseUrl/data' as Uri, headers: headers);

    return response;
  }

  // Aquí puedes agregar otras funciones que requieran el token
}

Future<int> getUserID(String email) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse('$baseUrl/users/register'));
  request.body = json.encode({"email": email});
  request.headers.addAll(headers);

  final response = await request.send();
  final respStr = await response.stream.bytesToString();
  var respJson = jsonDecode(respStr);

  if (response.statusCode == 200) {
    print("USER ID exitoso\n");
    print(respStr);

    return respJson['id_usuario']; //jsonDecode(response.body)['id'];
  } else {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("Error en getuserid " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.toString());
    return -1;
  }
}

Future<bool> fillUserInstance(int user_id) async {
  print("Enviando datos" + user_id.toString());
  String url =
      '$baseUrl/users/' + user_id.toString(); //el dolar se llama interpolacion

  //Esto es para enviar body en una llamada GET
  final response = await http.get(Uri.parse(url), headers: null);

  if (response.statusCode == 200) {
    print("Login exitoso");

    final respJson = jsonDecode(response.body);
    print(respJson);
    User_instance user_instance = User_instance.instance;
    user_instance.id = respJson['datos'][0]['id_usuario'];
    user_instance.nickname = respJson['datos'][0]['nickname'];
    user_instance.monedas = respJson['datos'][0]['monedas'];
    user_instance.email = respJson['datos'][0]['email'];
    user_instance.profile_pic = respJson['datos'][0]['profilephoto'];
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

// Eliminar cuenta de un usuario, utilizado desde 'Ajustes'
Future<void> eliminarCuenta(int idUsuario) async {
  final url = Uri.parse('$baseUrl/users/register/$idUsuario');

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Eliminación exitosa');
  } else {
    print('Error al eliminar: ${response.statusCode}');
  }
}

Future<String> actualizarAtributosUsuario(String name, String passwd) async {
  final url = Uri.parse('$baseUrl/users/register');
  late String body;

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${User_instance.instance.token}',
  };

  // Evitar enviar información redundante
  if (User_instance.instance.nickname == name) {
    body = jsonEncode(
        {'id_usuario': User_instance.instance.id, 'password': passwd});
  } else {
    body = jsonEncode({
      'id_usuario': User_instance.instance.id,
      'nickname': name,
      'password': passwd
    });
  }

  final response = await http.put(url, headers: headers, body: body);

  final responseJson = jsonDecode(response.body);

  // Handle response
  switch (response.statusCode) {
    case 200: // Ok
      return responseJson['message'];
    default: // Error
      return responseJson['msg'];
  }
}
