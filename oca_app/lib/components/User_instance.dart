//*****************************************************************
// File:   my_global_state.dart
// Author: Félix Ozcoz y Pablo López
// Date:   Abril 2023
// Coms: Almacén de información identificativa del usuario para
//       gestión de comunicación con backend
//*****************************************************************

class User_instance {
  static User_instance? _instance; // instancia única en la aplicación

  late String _email;
  late String _nickname;
  late int _id;
  late int _monedas;
  late String _profile_pic;

  User_instance._(); // Constructor privado

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
}
