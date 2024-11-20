import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  //api key
  final _weatherService = WeatherService('YOUR_API_KEY');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    Map<String, String> locationInfo = await _weatherService.getCurrentCity();
    String latitude = locationInfo['latitude']!;
    String longitude = locationInfo['longitude']!;

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(latitude, longitude);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'snow':
        return 'assets/snow.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloud.json';
    }
  }

  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weather == null)
              const CircularProgressIndicator.adaptive()
            else ...[
              Text(
                _weather!.city,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text(
                '${_weather?.temperature.round()}°C',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                _weather?.mainCondition ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
