import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'services/device_id_service.dart';
import 'utils/app_state.dart';
import 'screens/share_code_screen.dart';
import 'screens/enter_code_screen.dart';
import 'screens/movie_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final deviceIdService = DeviceIdService(prefs);

  runApp(MovieNightApp(deviceIdService: deviceIdService));
}

class MovieNightApp extends StatelessWidget {
  final DeviceIdService deviceIdService;

  const MovieNightApp({super.key, required this.deviceIdService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Movie Night',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: WelcomeScreen(deviceIdService: deviceIdService),
        routes: {
          '/share-code': (context) => const ShareCodeScreen(),
          '/enter-code': (context) => const EnterCodeScreen(),
          '/movie-selection': (context) => const MovieSelectionScreen(),
        },
      ),
    );
  }
}
