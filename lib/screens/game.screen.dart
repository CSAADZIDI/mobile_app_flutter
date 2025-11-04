import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isOk = false;
  int content = 0;

  void plusOne() {
    setState(() {
      if (content < 20) content++;
      _checkImageChange();
    });
  }

  void minusOne() {
    setState(() {
      if (content > 0) content--;
      _checkImageChange();
    });
  }

  void _checkImageChange() {
    // Change image when content is less than 10
    if (content < 10) {
      isOk = false;
    } else {
      isOk = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isOk ? "assets/images/ok.png" : "assets/images/not_ok.png"),
            const SizedBox(height: 20),
            Text(
              "$content",
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: minusOne,
                  child: const Text("-", style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: plusOne,
                  child: const Text("+", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
