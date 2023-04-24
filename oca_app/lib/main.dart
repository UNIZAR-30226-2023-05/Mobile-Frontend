import 'package:flutter/material.dart';
import 'package:oca_app/pages/create_lobby.dart';
import 'package:oca_app/pages/join_lobby.dart';
import 'package:oca_app/pages/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JoinLobby(),
    );
  }
}
