import 'package:flutter/material.dart';

class WaterData extends StatelessWidget {
  final String variableName;
  final String variableDescription;
  final String unit;
  final String value;
  final String time;

  const WaterData({
    super.key,
    required this.variableDescription,
    required this.variableName,
    required this.unit,
    required this.value,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
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
              ),
              Text(
                variableDescription,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
