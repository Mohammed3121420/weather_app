import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherModel;
  String? _errorMessage;
  bool _isLoading = false;

  WeatherModel? get weatherModel => _weatherModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getWeather({required String cityName}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weatherService = WeatherService(Dio());
      _weatherModel = await weatherService.getCurrentWeather(
        cityName: cityName,
      );
    } catch (e) {
      _errorMessage = e.toString();
      _weatherModel = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
