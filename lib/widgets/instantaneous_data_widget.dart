import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class InstantaneousDataWidget extends StatelessWidget {
  final String variableName;
  final String variableDescription;
  final String unit;
  final String value;
  final DateTime time;

  const InstantaneousDataWidget({
    super.key,
    required this.variableDescription,
    required this.variableName,
    required this.unit,
    required this.value,
    required this.time,
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
              '$variableName: $value $unit',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              variableDescription,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            Text(
              DateFormat("MMMM dd, y 'at' h:mm a", "en_US").format(time),
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
