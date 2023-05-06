import 'package:flutter/material.dart';
import 'package:oca_app/pages/statistics.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/pages/user_settings.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  void goToUserSettings() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          Image.asset('lib/images/logo.PNG', width: 170, height: 170),
          const SizedBox(height: 20),
          const Text('Menu de ajustes',
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontFamily: 'Caudex')),
          const SizedBox(height: 70),
          //MyButton(onPressed: goToUserSettings, textoAMostrar: "Ajustes del perfil"),
          ElevatedButton(
              style: GenericButton,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSettingsPage()));
              },
              child: const Text("Ajustes del perfil",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Caudex'))),
          const SizedBox(height: 60),
          ElevatedButton(
              style: GenericButton,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Statistics()));
              },
              child: const Text("Estadisticas",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Caudex'))),
        ]),
      )),
    );
  }
}
