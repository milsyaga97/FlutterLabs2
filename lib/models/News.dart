class NewsList {
  final List<NewsUnit> articles;

  NewsList({required this.articles});

  void extend(NewsList other) {
    articles.addAll(other.articles);
  }

  factory NewsList.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<NewsUnit> articlesList = list
        .map((i) => NewsUnit.fromJson(i))
        .toList();

    return NewsList(articles: articlesList);
  }
}

class NewsUnit {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final DateTime publishedAt;

  NewsUnit({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.publishedAt,
  });

  factory NewsUnit.fromJson(Map<String, dynamic> json) {
    return NewsUnit(
      source: json['source']['name'] ?? 'неизвестный источник',
      author: json['author'] ?? 'неизвестный автор',
      title: json['title'] ?? 'без названия',
      description: json['description'] ?? 'без описания',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? 'содержание отсутствует',
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
