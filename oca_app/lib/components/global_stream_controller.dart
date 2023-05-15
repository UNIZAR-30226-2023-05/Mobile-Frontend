import 'dart:async';
import 'package:rxdart/rxdart.dart';

class GlobalStreamController {
  static final GlobalStreamController _singleton =
      GlobalStreamController._internal();

  factory GlobalStreamController() {
    return _singleton;
  }

  GlobalStreamController._internal();

  final BehaviorSubject<dynamic> playersStreamController =
      BehaviorSubject<dynamic>.seeded([]);

  // Getter Stream
  Stream<dynamic> get playersStream => playersStreamController.stream;

  // Añadir dato a Stream
  void addData(dynamic data) {
    playersStreamController.sink.add(data);
  }

  void clearData() {
    playersStreamController.sink.add([]);
  }

  void dispose() {
    playersStreamController.close();
  }
}
