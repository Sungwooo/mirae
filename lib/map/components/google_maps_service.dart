import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyB40W4kQMayy_S-ysOrshDHOaZkv7wg1r8";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?mode=walking&language=en&origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);

    Map values = jsonDecode(response.body);
    if (values["status"] == "ZERO_RESULTS") {
      return "Not Supported this location.";
    }
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<String> getNavigateSteps(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?mode=walking&language=en&origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);

    Map values = jsonDecode(response.body);
    if (values["status"] == "ZERO_RESULTS") {
      return "Not Supported this location.";
    }
    return values["routes"][0]["legs"][0]["steps"].length != 1
        ? values["routes"][0]["legs"][0]["steps"][1]["html_instructions"]
            .toString()
            .replaceAll('<b>', '')
            .replaceAll('</b>', '')
            .split('<div')[0]
        : values["routes"][0]["legs"][0]["steps"][0]["html_instructions"]
            .toString()
            .replaceAll('<b>', '')
            .replaceAll('</b>', '')
            .split('<div')[0];
  }
}
