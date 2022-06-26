import 'dart:developer';

import 'package:flutter/material.dart';

import 'water_data.dart';

class WaterDatapoints {
  // source info
  final String siteName;
  final String siteCode;
  final double latitude;
  final double longitude;
  // variable info
  final List<WaterData> datapoints;

  const WaterDatapoints({
    required this.siteName,
    required this.siteCode,
    required this.latitude,
    required this.longitude,
    required this.datapoints,
  });

  static WaterDatapoints? fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json["value"]["timeSeries"];
    if (data.isEmpty) {
      return null;
    }
    return WaterDatapoints(
      siteName: data[0]["sourceInfo"]["siteName"] as String,
      siteCode: data[0]["sourceInfo"]["siteCode"][0]["value"] as String,
      latitude: data[0]["sourceInfo"]["geoLocation"]["geogLocation"]["latitude"] as double,
      longitude: data[0]["sourceInfo"]["geoLocation"]["geogLocation"]["longitude"] as double,
      datapoints: parseWaterData(data),
    );
  }

  static List<WaterData> parseWaterData(List<dynamic> data) {
    List<WaterData> datapoints = [];
    for (var datapoint in data) {
      String variableName = datapoint["variable"]["variableName"] as String;
      String variableDescription =
          datapoint["variable"]["variableDescription"] as String;
      String unit = datapoint["variable"]["unit"]["unitCode"] as String;
      String value = datapoint["values"][0]["value"][0]["value"] as String;
      String time = datapoint["values"][0]["value"][0]["dateTime"] as String;
      datapoints.add(
        WaterData(
            //variableName: variableName,
            // variableDescription: variableDescription,
            // unit: unit,
            // value: value,
            // time: time,
            ),
      );
    }
    return datapoints;
  }
}
