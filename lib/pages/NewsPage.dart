import 'package:News/models/News.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM, HH:mm', 'ru_RU').format(date);
}

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Не удалось открыть $url');
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.article});

  final NewsUnit article;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: TextStyle(fontWeight: FontWeight.w800, color: theme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.urlToImage!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                ),
              Text(
                article.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: theme.primary,
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(Icons.newspaper, size: 16, color: Colors.grey),
                  Text(
                    'Источник: ${article.source}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Spacer(),
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  Text(
                    formatDate(article.publishedAt),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                article.description,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.onSurface,
                  height: 1.6,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _openUrl(article.url);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: .center,
                    spacing: 5,
                    children: [
                      Icon(Icons.remove_red_eye),
                      Text(
                        'Перейти на источник',
                        style: TextStyle(fontSize: 16, fontWeight: .w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
