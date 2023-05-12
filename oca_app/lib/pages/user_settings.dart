import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:rxdart/rxdart.dart';

class UserSettingsPage extends StatelessWidget {
  UserSettingsPage({super.key});

  final List<String> imagePaths = [
    'https://i.postimg.cc/rwgky4HC/oca1.png',
    'https://i.postimg.cc/wBvd1v8K/oca2.png',
    'https://i.postimg.cc/DzM3LTnS/oca3.png',
    'https://i.postimg.cc/T1nzz5mb/oca4.png',
    'https://i.postimg.cc/hjQW05tp/oca5.png',
    'https://i.postimg.cc/BbWW7B8s/oca6.png',
  ];

  // Controladores de formularios
  final nameCtrl = TextEditingController();
  final passwdCtrl = TextEditingController();
  final repeatpasswdCtrl = TextEditingController();

  final BehaviorSubject<dynamic> imgCtrl = BehaviorSubject<dynamic>.seeded([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          const Text('Ajustes',
              style: TextStyle(
                  color: Colors.white, fontSize: 70, fontFamily: 'Caudex')),
          const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('Foto de perfil',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Caudex'))),
          SizedBox(
            height: 150,
            child: StreamBuilder<dynamic>(
              stream: imgCtrl.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierColor: Colors.black45,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Container(
                                  color: Colors.transparent,
                                  height: 400,
                                  width: 200,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // Nº de columnas en el grid
                                      mainAxisSpacing:
                                          10.0, // Espacio vert. entre los elementos
                                      crossAxisSpacing:
                                          10.0, // Espacio horizontal entre los elementos
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // Construye cada elemento del grid
                                      return InkWell(
                                        onTap: () {
                                          // Acción que se ejecutará cuando se toque la imagen
                                          User_instance.instance.profile_pic =
                                              imagePaths[index];
                                          imgCtrl.sink.add(imagePaths[index]);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Radio de las esquinas externas
                                            border: Border.all(
                                                color: Colors.blue,
                                                width:
                                                    2.0), // Borde de color azul
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26.withOpacity(
                                                    0.5), // Color de la sombra
                                                spreadRadius:
                                                    2, // Radio de difusión de la sombra
                                                blurRadius:
                                                    5, // Radio de desenfoque de la sombra
                                                offset: const Offset(0,
                                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Radio de las esquinas internas (bordes redondos)
                                            child: Image.network(
                                              imagePaths[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: imagePaths
                                        .length, // Número total de elementos en el grid
                                  )));
                        },
                      );
                    },
                    child: User_instance.instance.profile_pic == ""
                        ? Image.asset('lib/images/photo_icon.png',
                            width: 100, height: 100)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Radio de las esquinas externas
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 2.0), // Borde de color azul
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26
                                      .withOpacity(0.5), // Color de la sombra
                                  spreadRadius:
                                      2, // Radio de difusión de la sombra
                                  blurRadius:
                                      5, // Radio de desenfoque de la sombra
                                  offset: const Offset(0,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Radio de las esquinas internas (bordes redondos)
                              child: Image.network(
                                User_instance.instance.profile_pic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  );
                } else {
                  return Text('No photo selected');
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Editar',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: 'Caudex')),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white, size: 30),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  MyForm(
                      controller: nameCtrl,
                      hintText: "Nombre de usuario",
                      obscureText: false),
                  MyForm(
                      controller: passwdCtrl,
                      hintText: "Contraseña",
                      obscureText: true),
                  MyForm(
                      controller: repeatpasswdCtrl,
                      hintText: "Repetir contraseña",
                      obscureText: true),
                ],
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                          verticalDirection: VerticalDirection.up,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: GenericButton,
                                onPressed: () async {
                                  // Constraseñas iguales y Nombre de usuario distinto de vacío
                                  _checkChanges(context);
                                  if (_checkFormRestrictions(context)) {
                                    final responseMsg =
                                        await actualizarAtributosUsuario(
                                            nameCtrl.text, passwdCtrl.text);
                                    // ignore: use_build_context_synchronously
                                    _alertResponseMessage(context, responseMsg);
                                  }
                                },
                                child: const Text("Confirmar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Caudex'))),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                style: ErrorButton,
                                onPressed: () {
                                  User_instance ui = User_instance.instance;
                                  // Eliminar instancia de información de usuario y volver a Login
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                              "Eliminar cuenta",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // Muestra alerta non-null, pero siempre se inicializa
                                            content: Text(
                                                "¿ Desea eliminar la cuenta con nombre ${ui.nickname} ?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Borrar"),
                                                onPressed: () {
                                                  eliminarCuenta(ui.id);
                                                  ui.dispose(); // eliminar instancia del usuario
                                                  Navigator
                                                      .push // volver al pantalla incial
                                                      (
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginPage()));
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Cancelar"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ));
                                },
                                child: const Text("Eliminar cuenta",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Caudex')))
                          ]))))
        ]),
      )),
    );
  }

  // En principio las constraseñas pueden ser cualesquiera menos vacías
  bool _checkFormRestrictions(BuildContext context) {
    String name = nameCtrl.text;
    String passwd = passwdCtrl.text;
    String repPasswd = repeatpasswdCtrl.text;

    if (name == "" || passwd == "" || repeatpasswdCtrl == "") {
      _alertEmptyFields(context);
      return false;
    } else if (passwd != repPasswd) {
      _alertDifferentPasswd(context);
      return false;
    }

    // Campos rellenos y contraseñas coinciden
    return true;
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

  // Muestra un pop-up con un mensaje indicando que las contraseñas
  // no coinciden
  void _alertDifferentPasswd(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error"),
              // Muestra alerta non-null, pero siempre se inicializa
              content: const Text("Las contraseñas no coinciden"),
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

  // Muestra un pop-up con el mensaje que devuelve la respuesta http
  void _alertResponseMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              // Muestra alerta non-null, pero siempre se inicializa
              content: Text(message),
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

  void _checkChanges(BuildContext context, bool changePhoto) {
    if (changePhoto) {
    }
    // mirar si ha cambiado algo, y si lo ha cambiado que esté todo correcto
  }
}
