import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'result.screen.dart'; // updated import

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  // Pick image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Send image to Azure AI Vision
  Future<void> _sendImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    final String endpoint = 'https://visionprebuiltmodelcs.cognitiveservices.azure.com/';
    final String subscriptionKey = 'DTeIc46jK7rVge82NVxYkIFRxDSyuDenw7JMaRnpKscgVcjEpV1VJQQJ99BKAC5T7U2XJ3w3AAAFACOGOlwP';

    try {
      final bytes = await _selectedImage!.readAsBytes();

      final response = await http.post(
        Uri.parse('$endpoint/analyze?visualFeatures=Objects'),
        headers: {
          'Ocp-Apim-Subscription-Key': subscriptionKey,
          'Content-Type': 'application/octet-stream',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(result: result),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Photo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : const Placeholder(
                    fallbackWidth: 300,
                    fallbackHeight: 300,
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo),
              label: const Text("Pick from Gallery"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _sendImage,
              icon: const Icon(Icons.send),
              label: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
