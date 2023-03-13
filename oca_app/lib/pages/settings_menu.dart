import 'package:flutter/material.dart';
import 'package:oca_app/components/Buttons.dart';

class SettingsMenu extends StatelessWidget {
  SettingsMenu({super.key});

  void goToUserSettings(){}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset('lib/images/logo.PNG', width: 170, height: 170),
              const SizedBox(height: 20),
              const Text('Menu de ajustes', style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: 'Caudex')),
              const SizedBox(height: 70),
              MyButton(onPressed: goToUserSettings, textoAMostrar: "Ajustes del perfil"),
              const SizedBox(height: 60),
              MyButton(onPressed: goToUserSettings, textoAMostrar: "Estadisticas"),

            ]
          ),
        )
        ),
    );
  }
}