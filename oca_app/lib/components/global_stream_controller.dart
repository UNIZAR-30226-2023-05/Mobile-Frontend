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

  Stream<dynamic> get playersStream => playersStreamController.stream;

  void addData(dynamic data) {
    playersStreamController.sink.add(data);
  }

  void dispose() {
    playersStreamController.close();
  }
}
