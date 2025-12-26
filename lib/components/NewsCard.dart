import 'package:News/models/News.dart';
import 'package:News/pages/NewsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM, HH:mm', 'ru_RU').format(date);
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});
  final NewsUnit article;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NewsPage(article: article)),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    spacing: 5,
                    children: [
                      Column(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .start,
                        spacing: 10,
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            spacing: 5,
                            children: [
                              Text(
                                article.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: theme.primary,
                                ),
                              ),
                              Text(
                                article.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .center,
                            spacing: 10,
                            children: [
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    formatDate(article.publishedAt),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Icon(
                                    Icons.newspaper,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    article.source,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 150,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            article.urlToImage ??
                                'https://i.imgur.com/VAixCNq.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
