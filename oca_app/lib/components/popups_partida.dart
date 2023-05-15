import 'package:flutter/material.dart';
import 'package:oca_app/pages/main_menu.dart';

void popUpVolverATirar(
    BuildContext context, int casillaCaida, int casillaNueva) {
  switch (casillaCaida) {
    case 5:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 6:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Vaya!'),
            content: Text(
                '¡De puente a puente y tiro porque me lleva la corriente! \nHas caido en la casilla $casillaCaida, asi que te mueves hacia atrás a la casilla $casillaNueva y vuelves a tirar'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      break;
    case 9:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 12:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Vaya!'),
            content: Text(
                '¡De puente a puente y tiro porque me lleva la corriente! \nHas caido en la casilla $casillaCaida, pero esta vez te mueves hacia atrás a la casilla $casillaNueva y vuelves a tirar'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      break;
    case 14:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 18:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 23:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 26:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Te toca volver a tirar'),
            content: Text(
                '¡De dado a dado y tiro porque son cuadrados! \nEnhorabuena, has caido en unos dados, la casilla $casillaCaida, asi que te mueves a la casilla $casillaNueva y vuelves a tirar'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      break;
    case 27:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 32:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 36:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 41:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 45:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 50:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 53:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Vaya!'),
            content: Text(
                '¡De dado a dado y tiro porque son cuadrados! \nHas caido en la casilla $casillaCaida, pero esta vez te mueves hacia atrás a la casilla $casillaNueva y vuelves a tirar'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      break;
    case 54:
      popUpOca(context, casillaCaida, casillaNueva);
      break;
    case 54:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Enhorabuena!'),
            content: Text(
                '¡De oca a oca y... Victoria! \nHas caido en la casilla $casillaCaida, asi que te mueves a la casilla $casillaNueva y ganas la partida'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Cierra el Popup
                },
              ),
            ],
          );
        },
      );
      break;
  }
}

void popUpVictoria(BuildContext context) {
  print("PopUp Victoria");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('¡Has ganado!'),
        content: Text(
            'Enhorabuena, has ganado la partida, ahora seras redirigido al menú principal'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Main_Menu_Page()));
              // Cierra el Popup
            },
          ),
        ],
      );
    },
  );
}

void popUpOca(BuildContext context, int casillaCaida, int casillaNueva) {
  print("PopUp Oca");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Te toca volver a tirar'),
        content: Text(
            '¡De oca a oca y tiro porque me toca! \nHas caido en la casilla $casillaCaida, asi que te mueves a la casilla $casillaNueva y vuelves a tirar'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
              // Cierra el Popup
            },
          ),
        ],
      );
    },
  );
}

void popUpPenalizacion(BuildContext context) {
  print("PopUp penalizacion");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Estas penalizado'),
        content: Text(
            'Has caido en una casilla de penalizacion, asi que no puedes jugar este turno'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
              // Cierra el Popup
            },
          ),
        ],
      );
    },
  );
}

void popUpOtroGanador(BuildContext? context, String nombreGanador) {
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('¡Otra vez será!'),
        content: Text(
            'El jugador $nombreGanador ha ganado la partida, pero no te preocupes, sigue jugando y tu victoria llegará, ahora seras dirigido al menú principal'),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Main_Menu_Page()));
              // Cierra el Popup
            },
          ),
        ],
      );
    },
  );
}
