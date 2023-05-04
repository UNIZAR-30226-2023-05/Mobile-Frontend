// -------------------------------------------------------------------
// Nombre del fichero: join_lobby.dart
// Autoridades: Félix Ozcoz
// Fecha: mm-yy
// Descripción: ...
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class JoinRoomPage extends StatelessWidget {
  JoinRoomPage({super.key});

  final idRoomCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SocketSingleton ss = SocketSingleton.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1C6474),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(
            height: 70,
            width: double.infinity,
          ),
          Container(
            width: 390, //390,
            height: 700, // 700,
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
                const Text("¿Desea unirse a una \n sala existente?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                const SizedBox(height: 30),
                const Text("Código de la sala: *",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MyForm(
                    controller: idRoomCtrl,
                    hintText: "Introduzca nombre de la sala",
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Campo obligatorio*",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 45),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: [
                        ElevatedButton(
                          style: CrearButton,
                          onPressed: () async {
                            if (idRoomCtrl.text == "") {
                              _alertEmptyFields(context);
                            } else {
                              // Comprobar que sigue un formato
                              await ss.joinRoom(int.parse(idRoomCtrl.text));
                            }
                          },
                          child: const Text("Unirse",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Chivo',
                              )),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          // podría quitarse
                          style: CancelarButton,
                          onPressed: () async {
                            //print(User_instance.instance.idRoom);
                            // Vuelve a  menú principal
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Main_Menu_Page()));
                          },
                          child: const Text("Cancelar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Chivo',
                              )),
                        ),
                      ]),
                    ),
                  ),
                ),
              ]),
            ),
          )
        ]),
      )),
    );
  }

  // Muestra un pop-up indicando que los campos son vacíos
  void _alertEmptyFields(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error"),
              // Muestra alerta non-null, pero siempre se inicializa
              content: const Text("Rellena todos los campos"),
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
