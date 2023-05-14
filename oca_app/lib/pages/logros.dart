import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/social_func.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'dart:async';

class Logros extends StatefulWidget {
  @override
  State<Logros> createState() => _LosgrosState();
}

class _LosgrosState extends State<Logros> {
  var solicitudController = TextEditingController();
  final solicitudesController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  //Esto es una funcion que se ejecuta siempre que se inicia la pantalla social
  @override
  void initState() {
    super.initState();
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
                    "Logros",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
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
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
