import 'package:flutter/material.dart';

//define un estilo de botón
final RegistrarseButton = ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(const Size(170, 40)),
    backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 28, 100, 116)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Color.fromARGB(255, 28, 100, 116)))));

final LoginButton = ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(const Size(300, 60)),
    backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 129, 191, 205)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side:
                const BorderSide(color: Color.fromARGB(255, 129, 191, 205)))));
