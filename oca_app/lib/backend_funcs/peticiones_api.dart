import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://backendps.vercel.app';

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
