import 'package:flutter/material.dart';

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
        child: InstantaneousDataScreen(
          siteName: siteName,
          siteCode: siteCode,
        ),
      ),
    );
  }
}
