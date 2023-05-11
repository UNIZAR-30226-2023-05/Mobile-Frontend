// -------------------------------------------------------------------
// Nombre del fichero: create_lobby.dart
// Autoridades: Félix Ozcoz
// Fecha: mm-yy
// Descripción: ...
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/components/socket_class.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/pages/waiting_room.dart';
import 'package:oca_app/styles/buttons_styles.dart';

class CreateRoomPage extends StatelessWidget {
  CreateRoomPage({super.key});

  final roomNameCtrl = TextEditingController();
  final String NMINPLAYERS = "2"; // número de jugadores mínimo
  final nPlayersList = <String>["2", "3", "4", "5", "6"];

  @override
  Widget build(BuildContext context) {
    int nPlayers = int.parse(NMINPLAYERS);
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MyForm(
                    controller: roomNameCtrl,
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
                const Text(
                  "Número de jugadores: *",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: SizedBox(
                    height: kMinInteractiveDimension,
                    width: 100,
                    child: DropdownButtonFormField(
                      value: NMINPLAYERS, // número mínimo 2
                      items: nPlayersList.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        nPlayers = int.parse(value!); // guardar nº jugadores
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                            if (roomNameCtrl.text == "") {
                              _showAlertDialogEmptyFields(context);
                            } else {
                              _createRoom(context, nPlayers);
                            }
                          },
                          child: const Text("Crear",
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
                          style: CancelarButton,
                          onPressed: () async {
                            await ss.destroyRoom();

                            // ignore: use_build_context_synchronously
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

  void _showAlertDialogEmptyFields(BuildContext context) {
    showDialog(
        barrierColor: Colors.black45,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "Error",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content:
                  const Text("La sala creada debe tener un nombre no vacío."),
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

  void _createRoom(BuildContext context, int nPlayers) async {
    final response =
        await SocketSingleton.instance.createRoom(roomNameCtrl.text, nPlayers);

    switch (response['status']) {
      case true: /* ok */
        // Redirección a sala de juegos
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WaitingRoom(
                      roomName: roomNameCtrl.text,
                    )));
        break;
      default: /* error */
        // Redirección a menú principal
        // ignore: use_build_context_synchronously
        showDialog(
            barrierColor: Colors.black45,
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Error",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                      "Ha habido un error al crear la sala. \n Inténtelo de nuevo más tarde"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Main_Menu_Page()));
                      },
                      child: const Text("Atrás"),
                    )
                  ],
                ));
    }
  }
}
