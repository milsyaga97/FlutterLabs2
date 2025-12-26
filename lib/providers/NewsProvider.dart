import 'package:News/models/News.dart';
import 'package:News/services/NewsService.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  NewsList newsList = NewsList(articles: []);
  bool isLoading = false;
  String? errorMessage;
  int currentPage = 1;
  String newspaper = 'lenta';

  Map<String, String> sourcesNames = {
    'lenta': "Лента",
    'rbc': "РБС",
    'rt': "Rt",
  };

  void addPage() {
    currentPage++;
    fetch(currentPage);
  }

  void resetPade() {
    currentPage = 1;
    replaceFetch();
  }

  void changeNewsPaper(String newP) {
    newspaper = newP;
    replaceFetch();
  }

  Future<void> replaceFetch() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      isLoading = true;
      var newsList = await _newsService.fetchNews(currentPage, newspaper);
      this.newsList = newsList;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetch(int page) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      isLoading = true;
      var newsList = await _newsService.fetchNews(page, newspaper);
      this.newsList.extend(newsList);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
