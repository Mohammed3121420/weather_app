import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/widgets/custom_text.dart';
import '../provider/weather_provider.dart';
import '../widgets/no_weather_body.dart';
import '../widgets/weather_info_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const CustomText(text: "Weather App"),
      ),
      body: Builder(
        builder: (context) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (weatherProvider.weatherModel != null) {
            return const WeatherInfoBody();
          } else if (weatherProvider.errorMessage != null) {
            return Center(
              child: Text("Error: ${weatherProvider.errorMessage}"),
            );
          } else {
            return const NoWeatherBody();
          }
        },
      ),
    );
  }
}
