//*****************************************************************
// File:   my_global_state.dart
// Author: Félix Ozcoz y Pablo López
// Date:   Abril 2023
// Coms: Almacén de información identificativa del usuario para
//       gestión de comunicación con backend
//*****************************************************************

class MyGlobalState {
  static MyGlobalState _instance; // instancia única en la aplicación

  late String _email;
  late String _nickname;
  late int _id;

  MyGlobalState._(); // Constructor privado

  MyGlobalState.create(String email, String nickname, int id) {
    _email = email;
    _nickname = nickname;
    _id = id;
  }
  /*
  INFO:
  Devuelve la instancia única de la clase.
  Al llamar al método instance en la clase MyGlobalState, 
  se devuelve la única instancia de la clase. De esta manera, 
  se puede acceder a los datos o propiedades almacenados en dicha 
  instancia desde cualquier parte de la aplicación.
  */
  static MyGlobalState get instance {
    if (_instance == null) {
      // si no existe instancia la crea la primera vez que se utiliza
      _instance = MyGlobalState._();
    }
    return _instance;
  }

  String get email => _email;
  set email(String value) => _email = value;

  String get nickname => _nickname;
  set nickname(String value) => _nickname = value;

  int get id => _id;
  set id(int value) => _id = value;
}
