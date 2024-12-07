import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static String movieNightBaseUrl = 'https://movie-night-api.onrender.com';

  static Future<Map<String, dynamic>> startSession(String? deviceId) async {
    var response = await http.get(
      Uri.parse('$movieNightBaseUrl/start-session?device_id=$deviceId'),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> joinSession(
      String? deviceId, String code) async {
    var response = await http.get(
      Uri.parse(
          '$movieNightBaseUrl/join-session?device_id=$deviceId&code=$code'),
    );
    return jsonDecode(response.body);
  }
}
