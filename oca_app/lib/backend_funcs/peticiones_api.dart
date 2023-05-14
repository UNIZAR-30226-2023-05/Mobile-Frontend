import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/global_stream_controller.dart';

const String baseUrl = 'http://169.51.206.12:32021';
final GlobalStreamController logrosController = GlobalStreamController();

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

Future<Map<String, dynamic>> getDataFriend(int idFriend, String token) async {
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response =
      await http.get('$baseUrl/usuarios/$idFriend' as Uri, headers: headers);

  return jsonDecode(response.body);
}

Future<int> getUserIDemail(String email) async {
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
    print("Error en getuseridemail " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.toString());
    return -1;
  }
}

Future<int> getUserIDnickname(String nickname) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse('$baseUrl/users/register'));

  request.body = json.encode({"nickname": nickname});
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
    print("Error en getuseridnickname " +
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

Future<Map<String, dynamic>> actualizarAtributosUsuario(
    Map<String, dynamic> updatedAtributes) async {
  final url = Uri.parse('$baseUrl/users/register');

  Map<String, dynamic> retVal = {};

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${User_instance.instance.token}',
  };

  final response =
      await http.put(url, headers: headers, body: jsonEncode(updatedAtributes));

  final responseJson = jsonDecode(response.body);

  // Handle response
  switch (response.statusCode) {
    case 200: // Ok
      retVal = {'status': true, 'msg': responseJson['message']};
    default: // Error
      retVal = {'status': false, 'msg': responseJson['msg']};
  }

  return retVal;
}

Future<bool> getEstadisticas(int userID) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('GET', Uri.parse('$baseUrl/users/estadisticas/$userID'));

  //request.body = json.encode({"id_usuario": userID});
  //request.headers.addAll(headers);

  final response = await request.send();
  final respStr = await response.stream.bytesToString();
  var respJson = jsonDecode(respStr);

  if (response.statusCode == 200) {
    print("USER ID exitoso\n");
    print(respStr);
    //jsonDecode(response.body)['id'];

    User_instance.instance.ocas = respJson["estadisticas"]["vecesoca"];
    User_instance.instance.seises = respJson["estadisticas"]["vecesseis"];
    User_instance.instance.partidas =
        respJson["estadisticas"]["partidasjugadas"];
    User_instance.instance.victorias =
        respJson["estadisticas"]["partidasganadas"];
    User_instance.instance.calaveras =
        respJson["estadisticas"]["vecescalavera"];
    return true;
  } else {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("Error en getEstadisticas " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.toString());
    return false;
  }
}

Future<bool> getLogros(int userID) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET', Uri.parse('$baseUrl/users/logros/$userID'));

  //request.body = json.encode({"id_usuario": userID});
  //request.headers.addAll(headers);

  final response = await request.send();
  final respStr = await response.stream.bytesToString();
  var respJson = jsonDecode(respStr);

  if (response.statusCode == 200) {
    print("getLogros exitoso\n");
    print(respStr);
    //jsonDecode(response.body)['id'];

    return true;
  } else {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("Error en getLogros " +
        response.statusCode.toString() +
        "\n" +
        "\n" +
        response.toString());
    return false;
  }
}
