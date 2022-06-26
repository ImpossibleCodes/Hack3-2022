import 'package:flutter/material.dart';
import 'package:water_finder/screens/instantaneous_data_screen.dart';

class LocationDataWidget extends StatelessWidget {
  final double distance;
  final String name;
  final double latitude;
  final double longitude;
  final String siteNumber;

  const LocationDataWidget({
    super.key,
    required this.distance,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.siteNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstantaneousDataScreen(
                siteName: name,
                siteCode: siteNumber,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              Text(
                "$distance miles away",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                '$latitude, $longitude',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                "Site Number: $siteNumber",
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
