import 'package:flutter/material.dart';
import 'package:water_finder/widgets/instantaneous_datapoints_list_widget.dart';

class InstantaneousDataScreen extends StatelessWidget {
  final String siteName;
  final String siteCode;
  
  const InstantaneousDataScreen({
    super.key,
    required this.siteName,
    required this.siteCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(siteName),
      ),
      body: Center(
        child: InstantaneousDatapointsList(
          siteCode: siteCode,
        ),
      ),
    );
  }
}
