import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';

class SavedNewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedNews = ref.watch(savedNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: savedNews.isEmpty
          ? Center(child: Text('Your saved news will appear here.'))
          : ListView.builder(
              itemCount: savedNews.length,
              itemBuilder: (context, index) {
                final article = savedNews[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  leading: Image.network(article.urlToImage),
                );
              },
            ),
    );
  }
}