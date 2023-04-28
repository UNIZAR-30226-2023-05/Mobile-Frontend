import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:oca_app/backend_funcs/social_func.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';

class Social extends StatefulWidget {
  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  var solicitudController = TextEditingController();
  User_instance user_instance = User_instance.instance;
  late Future<List<String>> futureSolicitudes;

  //Esto es una funcion que se ejecuta siempre que se inicia la pantalla social
  @override
  void initState() {
    super.initState();
    futureSolicitudes = solicitudesPendientes(user_instance.id);
    print(futureSolicitudes);
  }

  void refreshSolicitudes() async {
    setState(() {
      futureSolicitudes = solicitudesPendientes(user_instance.id);
    });
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
                    onPressed: () {},
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
                      child: FutureBuilder<List<String>>(
                        future: futureSolicitudes,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                  child:
                                      Text('Error al cargar las solicitudes'));
                            } else {
                              List<String>? solicitudes = snapshot.data;
                              return SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      solicitudes?.length ?? 0, (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons
                                            .person), // Icono al principio del ListTile
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Solicitud entrante:',
                                                style: TextStyle(
                                                    color: Colors.green),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                solicitudes![index],
                                                style: TextStyle(
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
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
                                  }),
                                ),
                              );
                            }
                          }
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
