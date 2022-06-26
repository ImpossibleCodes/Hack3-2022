//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Water Finder',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
              ),
              Image(
                image: NetworkImage(
                    "https://publicdomainvectors.org/photos/1413121417.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Address or Coordinates',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('   Address   '),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FirstRoute()),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                  ),
                  ElevatedButton(
                    child: Text('Coordinates'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FirstRoute()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('test'),
        ),
      ),
    );
  }
}
