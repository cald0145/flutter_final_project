import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/device_id_service.dart';
import '../utils/app_state.dart';

// welcome screen widget that serves as the main entry point of app
class WelcomeScreen extends StatelessWidget {
  final DeviceIdService deviceIdService;

  const WelcomeScreen({super.key, required this.deviceIdService});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // set the device ID if not already set
    // manages device id through device id service and app state
// checks if device id is set
// retrieves and stores device id if not already set
//uses provider package for state management through app state
    if (appState.deviceId == null) {
      deviceIdService.getDeviceId().then((id) {
        appState.setDeviceId(id);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Night',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        color: Colors.blue[50],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Movie Night!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/share-code');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue[900],
                  ),
                  child: const Text('Get Code to Share'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/enter-code');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue[900],
                  ),
                  child: const Text('Enter Shared Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
