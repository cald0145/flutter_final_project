import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String? deviceId;
  String? sessionId;

  void setDeviceId(String id) {
    deviceId = id;
    notifyListeners();
  }

  void setSessionId(String id) {
    sessionId = id;
    notifyListeners();
  }
}
