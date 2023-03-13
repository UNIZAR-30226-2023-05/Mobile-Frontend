import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final Function()? onPressed;
  final String textoAMostrar;
  const MyButton({super.key, required this.onPressed, required this.textoAMostrar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 129, 191, 205),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Center(
        child: Text(
          textoAMostrar, 
          style: const TextStyle(
            color: Color.fromARGB(255, 8, 54, 65), 
            fontSize: 30, 
            fontWeight: FontWeight.normal,
            fontFamily: 'Chivo',)
        ),
      ),
    );
  }
}