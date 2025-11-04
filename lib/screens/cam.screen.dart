import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver2_fixed/image_gallery_saver2_fixed.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  File? _image;

  Future<void> _takePhoto() async {
    try {
      // Request permissions first
      await _requestPermissions();

      // Take photo
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      final File imageFile = File(pickedFile.path);

      // Save to gallery
      final bytes = await imageFile.readAsBytes();
      final result = await ImageGallerySaver.saveImage(bytes, quality: 100, name: "my_photo_${DateTime.now().millisecondsSinceEpoch}");
      print("Saved to gallery: $result");

      setState(() {
        _image = imageFile;
      });
    } on PlatformException catch (e) {
      print('Failed to take photo: $e');
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.camera.request();
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, width: 300, height: 300, fit: BoxFit.cover)
                : const Text("No image taken"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text("Take Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
