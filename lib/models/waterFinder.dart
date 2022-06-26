import 'dart:math';

import 'package:http/http.dart' as http;

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

double calculateDistance(
    double latitude1, double longitude1, double latitude2, double longitude2) {
  const double Radius = 3958.76;
  latitude1 *= pi / 180;
  longitude1 *= pi / 180;
  latitude2 *= pi / 180;
  longitude2 *= pi / 180;

  return acos(sin(latitude1) * sin(latitude2) +
          cos(latitude1) * cos(latitude2) * cos(longitude2 - longitude1)) *
      Radius;
}

List sortLocations(
    List locations, double originalLatitude, double originalLongitude) {
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
  return sortedLocationsX;
}

List parseData(final response) {
  String body = response.body;
  final split = body.split("\n").sublist(32);
  var subdivisions = [];
  split.forEach((String line) {
    final subdivide = line.split("\t");
    subdivisions.add(subdivide);
  });
  subdivisions.removeLast();
  return subdivisions;
}

void main() async {
  double latitude = 38.912;
  double longitude = -77.158810;
  double boxSize = 0.1;
  double displayLength = 5;

  if (latitude.abs() > 90) {
    return;
  } else if (longitude.abs() > 180) {
    return;
  }

  String apiURL = createURL(latitude, longitude, boxSize);

  var response = await http.get(Uri.parse(apiURL));
  final locations = parseData(response);
  final sortedLocationsX = sortLocations(locations, latitude, longitude);

  if (sortedLocationsX.length > displayLength) {
    for (int x = 0; x < displayLength; x++) {
      print("Location ${x + 1}");
      print("Distance: ${sortedLocationsX[x][0]} miles");
      print("Name: ${sortedLocationsX[x][3]}");
      print("Latitude: ${sortedLocationsX[x][5]}");
      print("Longitude: ${sortedLocationsX[x][6]}");
      print("Site Number: ${sortedLocationsX[x][2]}");
    }
  } else {
    for (int x = 0; x < sortedLocationsX.length; x++) {
      print("Location ${x + 1}");
      print("${"Distance: " + (sortedLocationsX[x][0])} miles");
      print("Name: ${sortedLocationsX[x][3]}");
      print("Latitude: ${sortedLocationsX[x][5]}");
      print("Longitude: ${sortedLocationsX[x][6]}");
      print("Site Number: ${sortedLocationsX[x][2]}");
    }
  }
}
