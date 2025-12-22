import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  Weather? weatherData;
  Image? weatherIcon;
  bool isLoading = true;
  String? errorMessage;

  String city = 'Ханты-Мансийск';
  final citylist = {
    'Ханты-Мансийск': [61.0054, 69.0252],
    'Сургут': [61.2481, 73.4012],
    'Нижневартовск': [60.9390, 76.5696],
    'Москва': [55.7558, 37.6173],
    'Санкт-Петербург': [59.9343, 30.3351],
    'Новосибирск': [55.0084, 82.9357],
    'Екатеринбург': [56.8389, 60.6057],
    'Казань': [55.7903, 49.1347],
    'Самара': [53.2415, 50.2212],
  };

  void changeCity(String newCity) {
    if (citylist.containsKey(newCity)) {
      city = newCity;
      fetchWeather(citylist[newCity]![0], citylist[newCity]![1]);
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      isLoading = true;
      weatherData = await _weatherService.fetchAPI(lat, lon);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
