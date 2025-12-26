import 'dart:convert';
import 'package:News/models/News.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<NewsList> fetchNews(int page, String source) async {
    final String apiKey = '5c74f8bb7d7047619d7eb8bc93817f09';
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?apiKey=$apiKey&language=ru&pageSize=10&sources=$source&page=$page',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);
      return NewsList.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Произошла ошибка при загрузке новостей');
    }
  }
}
