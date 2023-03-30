import 'package:http/http.dart' as http;

class LogIn {
  late String email;
  late String password;

  LogIn(String email, String password) {
    this.email = email;
    this.password = password;
  }

  Future<void> enviar() async {
    print("Enviando datos");
    const url = 'https://backendps.vercel.app/users/login';
    final body = {"email": email, "password": password};

    final response = await http.post(Uri.parse(url), headers: null, body: body);

    if (response.statusCode == 201) {
      print("Login exitoso");
    } else {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("Error en el Login " +
          response.statusCode.toString() +
          "\n" +
          "\n" +
          response.body);
    }
  }
}
