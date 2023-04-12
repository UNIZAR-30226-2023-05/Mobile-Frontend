// -------------------------------------------------------------------
// Nombre del fichero: join_lobby.dart
// Autoridades: Félix Ozcoz
// Fecha: mm-yy
// Descripción: ...
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class JoinLobby extends StatelessWidget {
  JoinLobby({super.key});

  final lobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1C6474),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(height: 70),
          Container(
            width: 390,
            height: 700,
            color: Colors.white,
            child: Container(
              color: const Color.fromARGB(255, 170, 250, 254),
              margin: const EdgeInsets.all(12),
              child: Column(children: [
                const Text('Unirse a una sala',
                    style: TextStyle(
                        color: Color.fromARGB(255, 28, 100, 116),
                        fontSize: 36,
                        fontFamily: 'Trocchi')),
                const SizedBox(height: 20),
                const Text("¿Desea unirse a una sala \n existente?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                const SizedBox(height: 70),
                const Text("Código de la sala: *",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                MyForm(
                  controller: lobbyController,
                  hintText: "Introduzca el código de la sala",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Campo obligatorio*",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 114),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: Row(children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: CrearButton,
                          onPressed: () {
                            if (lobbyController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text(
                                            "Rellena todos los campos"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      ));
                            }
                            //} else {
                            // gestionar el nombre de la sala
                            /*
                      Registro signUp = Registro(usernameController.text,
                          emailController.text, passwordController.text);
                      signUp.enviar();
                      */
                          },
                          child: const Text("Crear",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Chivo',
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: CancelarButton,
                          onPressed: () {
                            if (lobbyController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text(
                                            "Rellena todos los campos"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      ));
                            }
                          },
                          child: const Text("Cancelar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Chivo',
                              )),
                        ),
                      )
                    ]),
                  ),
                ),
              ]),
            ),
          )
        ]),
      )),
    );
  }
}
