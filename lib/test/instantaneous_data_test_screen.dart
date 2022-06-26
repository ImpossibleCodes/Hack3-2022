import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_finder/models/water_datapoints.dart';

class InstantaneousDataScreen extends StatefulWidget {
  const InstantaneousDataScreen({Key? key}) : super(key: key);

  @override
  State<InstantaneousDataScreen> createState() => _InstantaneousDataScreenState();
}

class _InstantaneousDataScreenState extends State<InstantaneousDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                FutureBuilder(
                  future: http.get(Uri.parse(
                      'https://waterservices.usgs.gov/nwis/iv/?format=json&indent=on&sites=01646500&siteStatus=all')),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      WaterDatapoints? waterDatapoints =
                          WaterDatapoints.fromJson(
                              jsonDecode(snapshot.data.body));
                      if (waterDatapoints != null) {
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: waterDatapoints.datapoints.length,
                            itemBuilder: (BuildContext context, int index) {
                              return waterDatapoints.datapoints[index];
                            },
                          ),
                        );
                      } else {
                        return const Text("No data");
                      }
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
  }
}