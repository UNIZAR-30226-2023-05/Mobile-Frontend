// -------------------------------------------------------------------
// Nombre del fichero: crear_sala.dart
// Autoridades: Félix Ozcoz , Pablo López
// Fecha: mm-yy
// Descripción: ...
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class CreateLobby extends StatelessWidget {
  CreateLobby({super.key});

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
                const Text('Crear sala',
                    style: TextStyle(
                        color: Color.fromARGB(255, 28, 100, 116),
                        fontSize: 36,
                        fontFamily: 'Trocchi')),
                const SizedBox(height: 20),
                const Text("¿Desea crear una sala?",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                const SizedBox(height: 30),
                const Text("Nombre de la sala: *",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                MyForm(
                  controller: lobbyController,
                  hintText: "Introduzca en nombre de la sala",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Campo obligatorio*",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 45),
                const Text(
                  "Número de jugadores: *",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                    height: kMinInteractiveDimension,
                    width: 100,
                    child: DropdownButtonFormField(
                      value: "2",
                      items: (<String>["2", "3", "4", "5", "6"]).map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        // almacenar el número de jugadores para luego utilizarlo
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      ),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      iconDisabledColor: Colors.black12,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          filled: true,
                          fillColor: Colors.white60),
                    ),
                  ),
                ),
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
