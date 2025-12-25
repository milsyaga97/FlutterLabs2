import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather.dart';

class WeatherService {
  Future<Weather> fetchAPI(double lat, double lon) async {
    String apiKey = '8a25706b-28e2-458b-8902-be0e90735ade';

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
