import 'dart:math';

import '../widgets/water_location_data.dart';

class WaterLocationDatapoints {
  final double originalLatitude;
  final double originalLongitude;
  final List<WaterLocationData> waterLocations;

  const WaterLocationDatapoints(
      {required this.originalLatitude,
      required this.originalLongitude,
      required this.waterLocations});

  static WaterLocationDatapoints? fromStr(
      String response, double originalLatitude, double originalLongitude) {
    final split = response.split("\n").sublist(32);
    var subdivisions = [];
    split.forEach((String line) {
      final subdivide = line.split("\t");
      subdivisions.add(subdivide);
    });
    subdivisions.removeLast();

    List locations = subdivisions;

    final distances = [];
    for (int i = 0; i < locations.length; i++) {
      double latitude = double.parse(locations[i][4]);
      double longitude = double.parse(locations[i][5]);
      distances.add([
        calculateDistance(
            latitude, longitude, originalLatitude, originalLongitude),
        i
      ]);
    }

    distances.sort((a, b) => (a[0] as double).compareTo((b[0] as double)));
    List sortedLocationsX = [];
    for (int i = 0; i < locations.length; i++) {
      int index = distances[i][1];
      double distance = distances[i][0];

      sortedLocationsX.add([distance.toString()] + locations[index]);
    }

    return WaterLocationDatapoints(
      originalLatitude: originalLatitude,
      originalLongitude: originalLongitude,
      waterLocations: parseLocations(sortedLocationsX),
    );
  }

  static double calculateDistance(double latitude1, double longitude1,
      double latitude2, double longitude2) {
    const double Radius = 3958.76;
    latitude1 *= pi / 180;
    longitude1 *= pi / 180;
    latitude2 *= pi / 180;
    longitude2 *= pi / 180;

    return acos(sin(latitude1) * sin(latitude2) +
            cos(latitude1) * cos(latitude2) * cos(longitude2 - longitude1)) *
        Radius;
  }

  static List<WaterLocationData> parseLocations(List sortedLocations) {
    List<WaterLocationData> list = [];
    for (int x = 0; x < sortedLocations.length; x++) {
      list.add(WaterLocationData(
          Distance: sortedLocations[x][0],
          Name: sortedLocations[x][3],
          Latitude: sortedLocations[x][5],
          Longitude: sortedLocations[x][6],
          SiteNumber: sortedLocations[x][2]));
    }
    return list;
  }
}
