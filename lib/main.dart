import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Finder',
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: const [
                Text("cool"),
                Text("text"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
