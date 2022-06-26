import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:water_finder/models/instantaneous_datapoints.dart';

class InstantaneousDatapointsList extends StatefulWidget {
  final String siteCode;

  const InstantaneousDatapointsList({
    super.key,
    required this.siteCode,
  });

  @override
  State<InstantaneousDatapointsList> createState() => _InstantaneousDatapointsListState();
}

class _InstantaneousDatapointsListState extends State<InstantaneousDatapointsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse('https://waterservices.usgs.gov/nwis/iv/?format=json&indent=on&sites=${widget.siteCode}&siteStatus=all')),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          WaterDatapoints? waterDatapoints = WaterDatapoints.fromJson(jsonDecode(snapshot.data.body));
          if (waterDatapoints != null) {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 8, right: 8),
              itemCount: waterDatapoints.datapoints.length,
              itemBuilder: (BuildContext context, int index) {
                return waterDatapoints.datapoints[index];
              },
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
    );
  }
}
