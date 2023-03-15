import 'package:flutter/material.dart';
import 'package:oca_app/pages/settings_menu.dart';
import 'package:oca_app/pages/sign_up.dart';
import 'package:oca_app/pages/user_settings.dart';
import 'pages/login_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}