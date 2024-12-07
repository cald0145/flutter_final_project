import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class DeviceIdService {
  static const String _deviceIdKey = 'device_id';
  final _androidId = const AndroidId();
  final _deviceInfo = DeviceInfoPlugin();
  final SharedPreferences _prefs;

  DeviceIdService(this._prefs);

  Future<String> getDeviceId() async {
    String? deviceId = _prefs.getString(_deviceIdKey);

    if (deviceId != null) return deviceId;

    if (Platform.isAndroid) {
      deviceId = await _androidId.getId() ?? '';
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? '';
    }

    await _prefs.setString(_deviceIdKey, deviceId!);
    return deviceId;
  }
}
