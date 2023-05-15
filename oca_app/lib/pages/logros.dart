import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/social_func.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'dart:async';
import 'package:oca_app/components/logros_class.dart';

class LogrosScreen extends StatefulWidget {
  final int userID;

  LogrosScreen({required this.userID});

  @override
  _LogrosScreenState createState() => _LogrosScreenState();
}

class _LogrosScreenState extends State<LogrosScreen> {
  late Future<List<Logro>> futureLogros;

  @override
  void initState() {
    super.initState();
    futureLogros = getLogros(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alineación a la izquierda
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Logros",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ), // Tu texto "Logros"
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.all(16.0), // Agrega un padding al FutureBuilder
                child: Container(
                  color: Colors
                      .white, // Agrega un color de fondo blanco al FutureBuilder
                  child: FutureBuilder<List<Logro>>(
                    future: futureLogros,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index].nombre),
                              trailing: Icon(
                                snapshot.data![index].completado
                                    ? Icons.check
                                    : Icons.close,
                                color: snapshot.data![index].completado
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // Mientras la petición está en curso, muestra un spinner de carga
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
