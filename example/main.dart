import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TouchRipple(
            // Called when the user taps or clicks.
            onTap: () => print("Hello, Tap!"),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Hello, World!", style: TextStyle(fontSize: 32, color: Colors.white)),
            ),
          ),
        )
      ),
    );
  }
}
