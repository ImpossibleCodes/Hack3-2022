import 'dart:math';

import 'package:water_finder/widgets/location_data_widget.dart';

class LocationDatapoints {
  final double originalLatitude;
  final double originalLongitude;
  final List<LocationDataWidget> waterLocations;

  const LocationDatapoints({
    required this.originalLatitude,
    required this.originalLongitude,
    required this.waterLocations,
  });

  static LocationDatapoints? fromStr(
      String response, double originalLatitude, double originalLongitude) {
    final split = response.split("\n").sublist(32);
    var subdivisions = [];
    for (var line in split) {
      final subdivide = line.split("\t");
      subdivisions.add(subdivide);
    }
    subdivisions.removeLast();

    List locations = subdivisions;

    final distances = [];
    for (int i = 0; i < locations.length; i++) {
      double latitude = double.parse(locations[i][4]);
      double longitude = double.parse(locations[i][5]);
      distances.add(
        [
          calculateDistance(
              latitude, longitude, originalLatitude, originalLongitude),
          i,
        ],
      );
    }

    distances.sort((a, b) => (a[0] as double).compareTo((b[0] as double)));
    List sortedLocationsX = [];
    for (int i = 0; i < locations.length; i++) {
      int index = distances[i][1];
      double distance = distances[i][0];

      sortedLocationsX.add([distance.toString()] + locations[index]);
    }

    return LocationDatapoints(
      originalLatitude: originalLatitude,
      originalLongitude: originalLongitude,
      waterLocations: parseLocations(sortedLocationsX),
    );
  }

  static double calculateDistance(double latitude1, double longitude1,
      double latitude2, double longitude2) {
    const double radius = 3958.76;
    latitude1 *= pi / 180;
    longitude1 *= pi / 180;
    latitude2 *= pi / 180;
    longitude2 *= pi / 180;

    return acos(sin(latitude1) * sin(latitude2) +
            cos(latitude1) * cos(latitude2) * cos(longitude2 - longitude1)) *
        radius;
  }

  static List<LocationDataWidget> parseLocations(List sortedLocations) {
    List<LocationDataWidget> list = [];
    for (int x = 0; x < sortedLocations.length; x++) {
      list.add(
        LocationDataWidget(
          distance: double.parse(sortedLocations[x][0]),
          name: sortedLocations[x][3],
          latitude: double.parse(sortedLocations[x][5]),
          longitude: double.parse(sortedLocations[x][6]),
          siteNumber: int.parse(sortedLocations[x][2]),
        ),
      );
    }
    return list;
  }
}
