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
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("App Bar")
          ,centerTitle: false,),
        body: const Center(child: Text("Body Item"),
        ),
      ),
    );
  }
}



