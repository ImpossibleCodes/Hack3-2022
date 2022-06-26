import 'dart:convert';

import 'package:http/http.dart' as http;


String getRequestURL(String siteNum) {
  String requestURL = 'https://waterservices.usgs.gov/nwis/iv/?format=json&indent=on&sites=$siteNum&siteStatus=all';
  return requestURL;
}

void main() async {
  String requestURL = getRequestURL('01646500');
  final response = await http.get(Uri.parse(requestURL));
  Map<String, dynamic> json = jsonDecode(response.body);
  List<dynamic> data = json['value']['timeSeries'];
  print(data[0]["sourceInfo"]["siteName"]);
}
