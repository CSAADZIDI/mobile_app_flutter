import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<void> initializeDotEnv() async {
  await dotenv.load(fileName: "assets/secrets/.env");
}

Future<http.Response> analyzeImage(File imageFile) async {
  
  final String endpoint = dotenv.env['AZURE_VISION_ENDPOINT'] ?? '';
  final String subscriptionKey = dotenv.env['AZURE_SUBSCRIPTION_KEY'] ?? '';
  
  final url = Uri.parse('$endpoint/vision/v3.2/analyze?visualFeatures=Objects,Tags,Description,People');
  // Read image bytes
  final bytes = await imageFile.readAsBytes();
  
      // Send POST request
  final response = await http.post(
    url,
    headers: {
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/octet-stream',
    },
    body: bytes,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // Print analysis results
    print('\nAnalyzing $imageFile\n');

    // Objects
    if (data['objects'] != null) {
      print('\nObjects in image:');
      for (var obj in data['objects']) {
        print(
          " ${obj['object']} (confidence: ${(obj['confidence'] * 100).toStringAsFixed(2)}%)",
        );
      }
    }
    return response;

    


  } else {
      print('Error: ${response.statusCode}');
      print(response.body);
      return response;
  }
}
    




