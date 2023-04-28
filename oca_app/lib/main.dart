import 'package:flutter/material.dart';
import 'package:oca_app/pages/join_lobby.dart';
import 'package:oca_app/pages/create_lobby.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';
import 'package:oca_app/pages/social.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  User_instance userInstance;
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
      home: LoginPage(
          //user_email: "userprueba@gmail.com",
          ),
    );
  }
}
