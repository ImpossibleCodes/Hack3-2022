import 'package:flutter/material.dart';
import 'package:water_finder/widgets/location_datapoints_list_widget.dart';

class LocationDataScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  
  const LocationDataScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: Center(
        child: LocationDatapointsList(
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }
}
