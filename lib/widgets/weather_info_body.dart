import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';
import 'custom_text.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    if (weatherProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherProvider.errorMessage != null) {
      return Center(
        child: CustomText(
          text: 'Error: ${weatherProvider.errorMessage}',
          style: const TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    if (weatherProvider.weatherModel == null) {
      return const Center(
        child: CustomText(
          text: "No weather data available.",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    final weatherModel = weatherProvider.weatherModel!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherModel.getThemeColor(),
            weatherModel.getThemeColor()[300]!,
            weatherModel.getThemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Expanded(
            child: CustomText(
              text: weatherModel.cityName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: CustomText(
              text:
                  'updated at : ${weatherModel.date.hour}:${weatherModel.date.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weatherModel.image != null
                  ? Image.network("https:${weatherModel.image}")
                  : Image.asset(weatherModel.getImage()),
              CustomText(
                text: '${weatherModel.temp.toInt()}°',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Column(
                children: [
                  CustomText(text: 'maxTemp: ${weatherModel.maxTemp.toInt()}°'),
                  CustomText(text: 'minTemp: ${weatherModel.minTemp.toInt()}°'),
                ],
              ),
            ],
          ),
          const Spacer(),
          CustomText(
            text: weatherModel.weatherCondition,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
