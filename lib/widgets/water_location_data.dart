import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:intl/intl.dart';

class WaterLocationData extends StatelessWidget {
  final double Distance;
  final String Name;
  final double Latitude;
  final double Longitude;
  final int SiteNumber;

  const WaterLocationData({
    super.key,
    required this.Distance,
    required this.Name,
    required this.Latitude,
    required this.Longitude,
    required this.SiteNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '$Name: $Latitude $Longitude',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              "$Distance miles away",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            Text(
              "Site Number: $SiteNumber",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
