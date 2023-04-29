import 'package:flutter/material.dart';
import 'package:oca_app/pages/join_lobby.dart';
import 'package:oca_app/pages/create_lobby.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/login_page.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:oca_app/pages/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:oca_app/backend_funcs/auth_model.dart';
import 'package:oca_app/pages/social.dart';
import 'package:oca_app/components/User_instance.dart';

void main() {
  User_instance userInstance = User_instance.instance;
/*
  userInstance.id = 62;
  userInstance.nickname = "userprueba";
  userInstance.email = "userprueba@gmail.com";
  userInstance.token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJwcnVlYmFAZ21haWwuY29tIiwiaWF0IjoxNjgyNzU4NTYwLCJleHAiOjE2ODMwMTc3NjB9.z1GXvDeeWlpOwCUfHa_F7k9_d4A2knUkkuxnqQUZ4tA";
*/
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
