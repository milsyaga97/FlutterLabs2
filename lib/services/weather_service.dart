import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather.dart';

class WeatherService {
  Future<Weather> fetchAPI(double lat, double lon) async {
    String apiKey = '9b411a2e-bb21-4a40-888b-f6c19133e634';

    final url = Uri.parse(
      'https://api.weather.yandex.ru/v2/forecast?lat=$lat&lon=$lon&lang=ru_RU',
    );
    final headers = {'X-Yandex-Weather-Key': apiKey};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }
}
