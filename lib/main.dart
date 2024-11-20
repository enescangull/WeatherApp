import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
            headlineMedium:
                TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            bodyLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
            bodySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
    );
  }
}
