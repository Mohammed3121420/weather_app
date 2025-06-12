import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';

import 'provider/weather_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          final themeColor =
              weatherProvider.weatherModel?.getThemeColor() ?? Colors.blue;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: themeColor),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
