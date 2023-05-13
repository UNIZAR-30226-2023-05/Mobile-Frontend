//*****************************************************************
// File:   User_instance.dart
// Author: Félix Ozcoz y Pablo López
// Date:   Abril 2023
// Coms: Almacén de información identificativa del usuario para
//       gestión de comunicación con backend
//*****************************************************************

class User_instance {
  static User_instance? _instance; // instancia única en la aplicación

  // Información identificativa de usuario
  late String _email;
  late String _nickname;
  late int _id;
  late String _token;

  // Información adicional de usuario
  late int _monedas;
  late String _profile_pic = "";

  // Información de control de salas
  late int _idRoom;
  late bool _soyLider;

  //informacion de partida
  bool _estaEnPartida = false;
  bool _isMyTurn = false;

  User_instance._(); // Constructor privado

  // Destructor de la clase  (utilizado al eliminar la instancia)
  void dispose() {
    _instance = null;
  }

  /*
  INFO:
  Devuelve la instancia única de la clase.
  Al llamar al método instance en la clase User_instance, 
  se devuelve la única instancia de la clase. De esta manera, 
  se puede acceder a los datos o propiedades almacenados en dicha 
  instancia desde cualquier parte de la aplicación.
  */
  static User_instance get instance {
    _instance ??= User_instance._(); // inicializa _instance solo si es null
    return _instance!;
  }

  String get email => _email;
  set email(String value) => _email = value;

  String get nickname => _nickname;
  set nickname(String value) => _nickname = value;

  int get id => _id;
  set id(int value) => _id = value;

  int get monedas => _monedas;
  set monedas(int value) => _monedas = value;

  String get profile_pic => _profile_pic;
  set profile_pic(String value) => _profile_pic = value;

  String get token => _token;
  set token(String value) => _token = value;

  int get idRoom => _idRoom;
  set idRoom(int value) => _idRoom = value;

  bool get soyLider => _soyLider;
  set soyLider(bool value) => _soyLider = value;

  bool get estaEnPartida => _estaEnPartida;
  set estaEnPartida(bool value) => _estaEnPartida = value;

  bool get isMyTurn => _isMyTurn;
  set isMyTurn(bool value) => _isMyTurn = value;
}
