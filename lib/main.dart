import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return const Text("Welcome");
    return const MaterialApp(
      home: Material(
        child: Center(
          child: Text("Testing Flutter"),
        ),
      ),
    );
  }
}



