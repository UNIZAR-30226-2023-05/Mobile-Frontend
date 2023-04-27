import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:oca_app/backend_funcs/social_func.dart';

class Social extends StatelessWidget {
  Social({super.key});

  var solicitudController = TextEditingController();

  void gotoAddFriend(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 190, 250, 254),
          title: const Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Añadir amigo",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 28, 100, 115),
                            fontFamily: 'Trocchi')),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Añade nuevos amigos mediante el correo del jugador",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )),
                SizedBox(height: 60),
                Text("Correo del jugador",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          content: Container(
            height: 200, // Establece la altura del contenido del popup
            child: Column(
              children: [
                // Aquí puedes colocar los widgets para introducir datos
                TextField(
                  // Configura tus campos de texto u otros widgets
                  controller: solicitudController,
                ),
                const Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("*Campo obligatorio",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                  ],
                ),
                // Otros widgets de introducción de datos
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                SolicitudAmistad solicitud = SolicitudAmistad(
                  "String",
                  solicitudController.text,
                );

                if (solicitud.enviar() == true) {
                  showPlatformDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 190, 250, 254),
                        title: const Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Solicitud enviada",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color:
                                              Color.fromARGB(255, 28, 100, 115),
                                          fontFamily: 'Trocchi')),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text("La solicitud se ha enviado correctamente",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              // Lógica para aceptar la acción
                              Navigator.pop(context);
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                // Lógica para cancelar la acción
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    "AMIGOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 220, top: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 650.0, // establece la altura del Sized Box
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount:
                            20, // establece la cantidad de elementos en la lista
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Elemento $index'),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        gotoAddFriend(
                            context); // llama a la función para mostrar la hoja modal
                      },
                      icon: Icon(Icons.person_add), // aquí se asigna el icono
                      label: Text(''), // aquí se asigna el texto del botón
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
