import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:water_finder/models/location_datapoints.dart';

class LocationDatapointsList extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double boxRadius;

  const LocationDatapointsList({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.boxRadius,
  });

  @override
  State<LocationDatapointsList> createState() => _LocationDatapointsListState();
}

class _LocationDatapointsListState extends State<LocationDatapointsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.latitude.abs() > 90) {
      return const Center(
        child: Text('Error: Invalid data'),
      );
    } else if (widget.longitude.abs() > 180) {
      return const Center(
        child: Text('Error: Invalid data'),
      );
    } else {
      return FutureBuilder(
        future: http
            .get(Uri.parse(createURL(widget.latitude, widget.longitude, widget.boxRadius))),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.body.toString().contains('No sites found')) {
              return const Text("No sites found! Try different location");
            }
            LocationDatapoints? locationDatapoints = LocationDatapoints.fromStr(
                snapshot.data.body, widget.latitude, widget.longitude);
            if (locationDatapoints != null) {
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 8, right: 8),
                itemCount: locationDatapoints.waterLocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return locationDatapoints.waterLocations[index];
                },
              );
            } else {
              return const Text("No sites found! Try different location");
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

  String truncate(String text, int length) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, "");
  }

  String createURL(double latitude, double longitude, double boxSize) {
    String westernLongitude = truncate((longitude - boxSize).toString(), 7);
    String southernLatitude = truncate((latitude - boxSize).toString(), 7);
    String easternLongitude = truncate((longitude + boxSize).toString(), 7);
    String northernLatitude = truncate((latitude + boxSize).toString(), 7);
    String url =
        "https://waterservices.usgs.gov/nwis/site/?format=rdb&bBox=$westernLongitude,$southernLatitude,$easternLongitude,$northernLatitude&siteStatus=all";
    return url;
  }
}
