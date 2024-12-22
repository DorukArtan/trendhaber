import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';

class SavedNewsPage extends ConsumerStatefulWidget {
  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends ConsumerState<SavedNewsPage> {
  @override
  Widget build(BuildContext context) {
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
                  leading: FadeInImage.assetNetwork(
                    placeholder: 'trendhaber.jpg',
                    image: article.urlToImage,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'trendhaber.jpg',
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}