// -------------------------------------------------------------------
// Nombre del fichero: crear_sala.dart
// Autoridades: Félix Ozcoz , Pablo López
// Fecha: mm-yy
// Descripción: ...
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';

class CreateLobby extends StatelessWidget {
  CreateLobby({super.key});

  final lobbyController = TextEditingController();
  static List<String> listaDeOpciones = <String>["2", "3", "4", "5", "6"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 28, 100, 116),
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
                const Text('Crear sala',
                    style: TextStyle(
                        color: Color.fromARGB(255, 28, 100, 116),
                        fontSize: 36,
                        fontFamily: 'Trocchi')),
                const SizedBox(height: 20),
                const Text("¿Desea crear una sala?",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                //OJO, NO SE POR QUÉ NECESITAS UNA SIZED BOX AQUI PARA QUE SE CENTRE EL ICONO
                const SizedBox(height: 30),
                const Text("Nombre de la sala: *",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                MyForm(
                    controller: lobbyController,
                    hintText: "",
                    obscureText: false),
                const Text("Campo obligatorio*",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                const SizedBox(height: 20),
                const Text("Número de jugadores: *",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                const SizedBox(height: 15),
                DropdownButtonFormField(
                    items: listaDeOpciones.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {})
                /*
                ElevatedButton(
                  style: RegistrarseButton,
                  onPressed: () {
                    if (usernameController.text == "" ||
                        emailController.text == "" ||
                        passwordController.text == "" ||
                        repeatpasswordController.text == "") {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Error"),
                                content: const Text("Rellena todos los campos"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ));
                    } else if (passwordController.text !=
                        repeatpasswordController.text) {
                      showDialog(
                          context: context,
                          builder: (builder) => AlertDialog(
                                title: const Text("Error"),
                                content:
                                    const Text("Las contraseñas no coinciden"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ));
                    } else {
                      Registro signUp = Registro(usernameController.text,
                          emailController.text, passwordController.text);
                      signUp.enviar();
                    }
                  },
                  child: const Text("Registrarse",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Chivo',
                      )),
                ),*/
              ]),
            ),
          )
        ]),
      )),
    );
  }
}
