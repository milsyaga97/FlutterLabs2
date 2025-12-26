import 'package:News/components/NewsCard.dart';
import 'package:News/providers/NewsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    final newsContext = context.read<NewsProvider>();
    Future.microtask(() => newsContext.fetch(1));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final newsContext = context.read<NewsProvider>();
      newsContext.addPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    final newsContext = context.watch<NewsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'Новости',
              style: TextStyle(fontWeight: .w800, color: theme.primary),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    newsContext.resetPade();
                  },
                  icon: Icon(Icons.restore),
                ),
                MenuAnchor(
                  menuChildren: [
                    for (var sourceName in newsContext.sourcesNames.keys)
                      MenuItemButton(
                        onPressed: () {
                          newsContext.changeNewsPaper(sourceName);
                        },
                        child: Text(newsContext.sourcesNames[sourceName]!),
                      ),
                  ],
                  builder: (context, controller, child) => ElevatedButton(
                    child: Row(
                      spacing: 2,
                      children: [
                        Icon(Icons.newspaper),
                        Text(
                          newsContext.sourcesNames[newsContext.newspaper]!,
                          style: TextStyle(fontSize: 14, fontWeight: .w800),
                        ),
                      ],
                    ),
                    onPressed: () {
                      controller.open();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: newsContext.newsList.articles.isEmpty
          ? Center(
              child: Text(
                'Новостей нет.',
                style: TextStyle(
                  color: theme.primary,
                  fontWeight: .w800,
                  fontSize: 18,
                ),
              ),
            )
          : ListView(
              controller: _scrollController,
              children: [
                if (newsContext.isLoading &&
                    newsContext.newsList.articles.isEmpty)
                  const LinearProgressIndicator(),
                ...newsContext.newsList.articles.map(
                  (newsUnit) => NewsCard(article: newsUnit),
                ),
              ],
            ),
    );
  }
}
