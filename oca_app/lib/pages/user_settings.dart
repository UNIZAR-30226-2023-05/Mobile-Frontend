import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
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
              onPressed: () {},
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
              onPressed: () {},
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
