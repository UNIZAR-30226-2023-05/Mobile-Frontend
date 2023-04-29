import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:oca_app/backend_funcs/social_func.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'dart:async';

class Social extends StatefulWidget {
  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  var solicitudController = TextEditingController();
  User_instance user_instance = User_instance.instance;
  final solicitudesController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  //Esto es una funcion que se ejecuta siempre que se inicia la pantalla social
  @override
  void initState() {
    super.initState();
    solicitudesPendientes(user_instance.id).then((solicitudes) {
      listaAmigos(user_instance.id).then((amigos) {
        solicitudesController.add([...solicitudes, ...amigos]);
      });
    });
  }

  Future<void> fetchData() async {
    final solicitudes = await solicitudesPendientes(user_instance.id);
    final amigos = await listaAmigos(user_instance.id);
    solicitudesController.add([...solicitudes, ...amigos]);
  }

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
              onPressed: () async {
                if (await enviarSolicitudAmistad(
                    await getUserID(user_instance.email),
                    await getUserID(solicitudController.text))) {
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  showPlatformDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor:
                            const Color.fromARGB(255, 190, 250, 254),
                        title: const Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Solicitud enviada",
                                      style: TextStyle(
                                          fontSize: 28,
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
                              fetchData();
                              // Lógica para aceptar la acción
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  showPlatformDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor:
                            const Color.fromARGB(255, 190, 250, 254),
                        title: const Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Error en la solicitud",
                                      style: TextStyle(
                                          fontSize: 28,
                                          color:
                                              Color.fromARGB(255, 28, 100, 115),
                                          fontFamily: 'Trocchi')),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text("La solicitud no se ha enviado",
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
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
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
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, top: 10),
                  child: const Text(
                    "AMIGOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 200, top: 10),
                  child: IconButton(
                    onPressed: () {
                      fetchData();
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 650.0,
                    child: Container(
                        color: Colors.white,
                        child: StreamBuilder<List<Map<String, dynamic>>>(
                          stream: solicitudesController.stream,
                          initialData: [],
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Error al cargar las solicitudes'));
                              } else {
                                List<Map<String, dynamic>>? data =
                                    snapshot.data;
                                if (data != null && data.isNotEmpty) {
                                  List<Widget> solicitudesAmistad = data
                                      .where((element) =>
                                          element['tipo'] == 'solicitud')
                                      .map<Widget>((element) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide()),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Solicitud entrante:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Text(
                                              element['nickname'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () {
                                            // Aquí, coloca la lógica para aceptar la solicitud de amistad
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList();

                                  List<Widget> amigos = data
                                      .where((element) =>
                                          element['tipo'] == 'amigo')
                                      .map<Widget>((element) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide()),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text("${element['nickname']}"),
                                      ),
                                    );
                                  }).toList();

                                  return ListView(
                                    children: solicitudesAmistad + amigos,
                                  );
                                } else {
                                  return Center(
                                      child: Text(
                                          'No tienes amigos, agrega uno dandole a la lupa'));
                                }
                              }
                            }
                          },
                        )),
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
