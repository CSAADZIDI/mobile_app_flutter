import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final objects = result['objects'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Detection Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: objects.isEmpty
            ? const Center(child: Text("No objects detected"))
            : ListView.builder(
                itemCount: objects.length,
                itemBuilder: (context, index) {
                  final obj = objects[index];
                  final name = obj['object'] ?? 'Unknown';
                  final confidence = obj['confidence'] ?? 0.0;
                  final rect = obj['rectangle'] ?? {};

                  return Card(
                    child: ListTile(
                      title: Text(name),
                      subtitle: Text(
                          'Confidence: ${(confidence * 100).toStringAsFixed(1)}%\nRectangle: $rect'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
