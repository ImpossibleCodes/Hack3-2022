import 'package:flutter/material.dart';
import 'package:water_finder/screens/home_screen.dart';
// import 'package:water_finder/screens/instantaneous_data_screen.dart';
// import 'package:water_finder/screens/location_data_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // home: const InstantaneousDataScreen(
      //   siteName: 'Site name',
      //   siteCode: '01646500',
      // ),
      home: const HomeScreen(),
    );
  }
}
