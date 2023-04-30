import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class UserSettings extends StatelessWidget {
  UserSettings({super.key});

  void saveSettings() {}
  void deleteAccount() {}

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          const Text('Ajustes',
              style: TextStyle(
                  color: Colors.white, fontSize: 70, fontFamily: 'Caudex')),
          const Text('Foto de perfil',
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'Caudex')),
          //PLACEHOLDER, AQUI TIENE QUE IR LA FOTO DE PERFIL DEL USUARIO
          Image.asset('lib/images/photo_icon.png', width: 150, height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Editar',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'Caudex')),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white, size: 30),
              ),
            ],
          ),
          //MyButton(onPressed: goToUserSettings, textoAMostrar: "Ajustes del perfil"),
          //MyButton(onPressed: goToUserSettings, textoAMostrar: "Estadisticas"),
          MyForm(
              controller: usernameController,
              hintText: "Nombre de usuario",
              obscureText: false),
          MyForm(
              controller: passwordController,
              hintText: "Contraseña",
              obscureText: true),
          MyForm(
              controller: repeatpasswordController,
              hintText: "Repetir contraseña",
              obscureText: true),

          const SizedBox(height: 20),
          //MyButton(onPressed: saveSettings, textoAMostrar: "Confirmar"),
          ElevatedButton(
              style: GenericButton,
              onPressed: () {
                // Constraseñas iguales y Nombre de usuario distinto de vacío
              },
              child: const Text("Confirmar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Caudex'))),
          const SizedBox(height: 30),
          /*DeleteButton(
              onPressed: deleteAccount, textoAMostrar: "Eliminar cuenta"),*/
          ElevatedButton(
              style: ErrorButton,
              onPressed: () {
                User_instance ui = User_instance.instance;
                // Petición al backend para que borre la cuenta
                // Indicar que se ha eliminado la cuenta y volver a LoginPage
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Cuenta borrada"),
                          // Muestra alerta non-null, pero siempre se inicializa
                          content: Text(
                              "La cuenta de usuario con nombre ${ui.nickname} ha sido eliminada"),
                          actions: [
                            TextButton(
                              child: Text("Borrar"),
                              onPressed: () {
                                eliminarCuenta(ui.id); // conexión con BBDD
                                ui.dispose(); // eliminar instancia del usuario
                                Navigator.push // volver al pantalla incial
                                    (
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                              },
                            ),
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
              },
              child: const Text("Eliminar cuenta",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Caudex'))),
        ]),
      )),
    );
  }
}
