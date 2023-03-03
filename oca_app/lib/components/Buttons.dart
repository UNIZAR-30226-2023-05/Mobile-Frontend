import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 129, 191, 205),
        borderRadius: BorderRadius.circular(35),
      ),
      child: const Center(
        child: Text(
          'Iniciar sesión', 
          style: TextStyle(
            color: Color.fromARGB(255, 8, 54, 65), 
            fontSize: 30, 
            fontWeight: FontWeight.normal,
            fontFamily: 'Chivo',)
        ),
      ),
    );
  }
}