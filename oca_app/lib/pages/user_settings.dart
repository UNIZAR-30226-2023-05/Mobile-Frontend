import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class UserSettingsPage extends StatelessWidget {
  UserSettingsPage({super.key});

  void saveSettings() {}
  void deleteAccount() {}

  // Controladores de formularios
  final nameCtrl = TextEditingController();
  final passwdCtrl = TextEditingController();
  final repeatpasswdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 28, 100, 116),
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
              controller: nameCtrl,
              hintText: "Nombre de usuario",
              obscureText: false),
          MyForm(
              controller: passwdCtrl,
              hintText: "Contraseña",
              obscureText: true),
          MyForm(
              controller: repeatpasswdCtrl,
              hintText: "Repetir contraseña",
              obscureText: true),

          const SizedBox(height: 20),
          //MyButton(onPressed: saveSettings, textoAMostrar: "Confirmar"),
          ElevatedButton(
              style: GenericButton,
              onPressed: () {
                // Constraseñas iguales y Nombre de usuario distinto de vacío
                if (_checkFormRestrictions(context)) {
                  actualizarAtributosUsuario(nameCtrl.text, passwdCtrl.text);
                }
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
                // Eliminar instancia de información de usuario y volver a Login
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Eliminar cuenta"),
                          // Muestra alerta non-null, pero siempre se inicializa
                          content:
                              Text("¿ Desea eliminar la cuenta con nombre X ?"),
                          actions: [
                            TextButton(
                              child: const Text("Borrar"),
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
                              child: Text("Cancelar"),
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

  // En principio las constraseñas pueden ser cualesquiera menos vacías
  bool _checkFormRestrictions(BuildContext context) {
    String name = nameCtrl.text;
    String passwd = passwdCtrl.text;
    String repPasswd = repeatpasswdCtrl.text;

    if (name == "" || passwd == "" || repeatpasswdCtrl == "") {
      _alertEmptyFields(context);
      return false;
    } else if (passwd != repPasswd) {
      _alertDifferentPasswd(context);
      return false;
    }

    // útlimo caso está bien, ambas contraseñas coinciden
    return true;
  }

  void _alertEmptyFields(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error"),
              // Muestra alerta non-null, pero siempre se inicializa
              content: Text("Rellena todos los campos"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  void _alertDifferentPasswd(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error"),
              // Muestra alerta non-null, pero siempre se inicializa
              content: const Text("Las contraseñas no coinciden"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
