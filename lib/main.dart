import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'services/device_id_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final deviceIdService = DeviceIdService(prefs);

  runApp(MovieNightApp(deviceIdService: deviceIdService));
}

class MovieNightApp extends StatelessWidget {
  final DeviceIdService deviceIdService;

  const MovieNightApp({Key? key, required this.deviceIdService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Night',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: WelcomeScreen(deviceIdService: deviceIdService),
      routes: {
        '/share-code': (context) =>
            const Placeholder(), // TODO: Implement share code screen
        '/enter-code': (context) =>
            const Placeholder(), // TODO: Implement enter code screen
      },
    );
  }
}
