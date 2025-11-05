import 'package:flutter/material.dart';
//import 'package:mobile_app_flutter/services/azaivision.service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Function to load environment variables
Future<void> initializeDotEnv() async {
  await dotenv.load(fileName: "assets/secrets/.env");
}

Future<void> main() async {
  // Ensure Flutter bindings are initialized before async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  await initializeDotEnv();

  // Access environment variable loaded earlier
  final apiUrl = dotenv.env['AI_SERVICE_ENDPOINT'] ?? 'AI_SERVICE_ENDPOINT not found';
  print('AI_SERVICE_ENDPOINT: $apiUrl');
  // Pass apiUrl into the app
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
 

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(
          child: Text('Check console for AI_SERVICE_ENDPOINT'),
        ),
      ),
    );
  }
}
