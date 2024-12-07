import 'package:flutter/material.dart';
import '../services/device_id_service.dart';

class WelcomeScreen extends StatelessWidget {
  final DeviceIdService deviceIdService;

  const WelcomeScreen({Key? key, required this.deviceIdService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
