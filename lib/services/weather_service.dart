import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String lat, String lon) async {
    var response = await http.get(Uri.parse(
      '$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
    ));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, String>> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }
    }

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    return {
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString()
    };
  }
}
