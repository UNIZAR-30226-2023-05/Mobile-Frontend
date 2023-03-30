import 'package:flutter/material.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Main_Menu_Page extends StatelessWidget {
  Main_Menu_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 28, 100, 116),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsMenu()));
                      },
                      icon: const Icon(Icons.settings,
                          color: Colors.white, size: 45)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (builder) => AlertDialog(
                                  title: const Text("OCA LOCA"),
                                  content: const Text(
                                      "POP UP para mostrar las instrucciones del juego"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"),
                                    )
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.question_mark,
                          color: Colors.white, size: 45)),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                //logo
                Image.asset('lib/images/logo.PNG', width: 200, height: 200),
                //const SizedBox(height: 25),
                //OCA LOCA
                const Text('OCA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: 'Caudex')),
                const Text('LOCA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Caudex')),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: GenericButton,
                    onPressed: () {},
                    child: const Text(
                      "Crear una sala",
                      style: TextStyle(fontSize: 25, fontFamily: 'Caudex'),
                    )),

                const SizedBox(height: 40),
                ElevatedButton(
                    style: GenericButton,
                    onPressed: () {},
                    child: const Text(
                      "Unirse a una sala",
                      style: TextStyle(fontSize: 25, fontFamily: 'Caudex'),
                    )),

                const SizedBox(height: 140),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart,
                              color: Colors.white, size: 45)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(MdiIcons.accountGroup,
                              color: Colors.white, size: 45)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
