import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// app state class that extends change notifier to manage state and notify listeners
class AppState with ChangeNotifier {
  String? _deviceId; // private variable to store device id
  String? _sessionId; // private variable to store session id
  final SharedPreferences
      _prefs; // shared preferences instance for persistent storage

  // constructor to initialize shared preferences and load stored values
  AppState(this._prefs) {
    _deviceId =
        _prefs.getString('device_id'); // load device id from shared preferences
    _sessionId = _prefs
        .getString('session_id'); // load session id from shared preferences
  }

  // getter for device id
  String? get deviceId => _deviceId;
  // getter for session id
  String? get sessionId => _sessionId;

  // method to set device id and save it in shared preferences
  void setDeviceId(String id) {
    _deviceId = id;
    _prefs.setString('device_id', id);
    notifyListeners(); // notify listeners about the change
  }

  // method to set session id and save it in shared preferences
  void setSessionId(String id) {
    _sessionId = id;
    _prefs.setString('session_id', id);
    notifyListeners(); // notify listeners about the change
  }
}
