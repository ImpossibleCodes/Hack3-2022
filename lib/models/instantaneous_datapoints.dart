import 'package:water_finder/widgets/instantaneous_data_widget.dart';

class WaterDatapoints {
  // source info
  final String siteName;
  final String siteCode;
  final double latitude;
  final double longitude;
  // variable info
  final List<InstantaneousDataWidget> datapoints;

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

  static List<InstantaneousDataWidget> parseWaterData(List<dynamic> data) {
    List<InstantaneousDataWidget> datapoints = [];
    for (var datapoint in data) {
      String variableName = datapoint["variable"]["variableName"] as String;
      variableName = variableName.replaceAll(RegExp(r',.*'), '');
      String variableDescription = datapoint["variable"]["variableDescription"] as String;
      String unit = datapoint["variable"]["unit"]["unitCode"] as String;
      String value = datapoint["values"][0]["value"][0]["value"] as String;
      double noDataValue = datapoint["variable"]["noDataValue"] as double;
      if (double.parse(value) == noDataValue) {
        value = "No Data Found";
        continue;
      }
      DateTime time = DateTime.parse(datapoint["values"][0]["value"][0]["dateTime"] as String);
      datapoints.add(
        InstantaneousDataWidget(
          variableName: variableName,
          variableDescription: variableDescription,
          unit: unit,
          value: value,
          time: time,
        ),
      );
    }
    return datapoints;
  }
}
