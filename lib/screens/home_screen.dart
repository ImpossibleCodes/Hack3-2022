import 'package:flutter/material.dart';
import 'package:water_finder/screens/location_data_screen.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  late TextEditingController _controller;
  String text = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void goToSecondPage(bool isAddress) async {
    double latitude = 0;
    double longitude = 0;

    if (!isAddress) {
      List coords = text.split(" ");
      latitude = double.parse(coords[0]);
      longitude = double.parse(coords[1]);
    } else {
      // latitude = 38.94977778;
      // longitude = -77.127638889;
      Position position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }

    if (latitude.abs() > 90) {
      return;
    } else if (longitude.abs() > 180) {
      return;
    }

    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LocationDataScreen(latitude: latitude, longitude: longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Wander',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(24),
              ),
              const Image(
                image: AssetImage('assets/water_icon.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(24),
              ),
              TextField(
                controller: _controller,
                onChanged: (String value) async {
                  text = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter in form "latitude longitutde"',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Use My Location'),
                    onPressed: () {
                      goToSecondPage(true);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  ElevatedButton(
                    child: const Text('Coordinates'),
                    onPressed: () {
                      goToSecondPage(false);
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
