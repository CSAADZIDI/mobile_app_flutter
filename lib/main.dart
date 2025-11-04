//import 'package:demo_flutter/screens/darklight.screen.dart';
// import 'package:demo_flutter/screens/hello.screen.dart';
//import 'package:demo_flutter/screens/game.screen.dart';
//import 'package:demo_flutter/screens/cam.screen.dart';
import 'package:demo_flutter/screens/gallery.screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: GalleryScreen(),//CamScreen(),//GameScreen(), // DarkLightScreen(), // HelloScreen(user: "Chaima "),
      ),
    );
  }
}

