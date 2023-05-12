import 'package:flutter/material.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/oca_game.dart';
import 'package:oca_app/pages/user_settings.dart';
import 'package:oca_app/pages/waiting_room.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
