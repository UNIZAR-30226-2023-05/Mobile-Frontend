import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'package:oca_app/components/User_instance.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  void goToUserSettings() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          SizedBox(height: 20),
          Text('Estadisticas',
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontFamily: 'Caudex')),
          SizedBox(height: 60),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Victorias',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(
                                    User_instance.instance.victorias.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Partidas jugadas',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(User_instance.instance.partidas.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Oca',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(User_instance.instance.ocas.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Calavera',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(
                                    User_instance.instance.calaveras.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Seis',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(User_instance.instance.seises.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 90,
                          width: 170,
                          child: Card(
                            color: Color.fromARGB(255, 195, 250, 254),
                            child: Column(
                              children: [
                                Text('Monedas',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                                Text(User_instance.instance.monedas.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Caudex')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
