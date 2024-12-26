import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                return Dismissible(
                  key: Key(article.url),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ref.read(savedNewsProvider.notifier).removeArticle(article);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Article removed')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final url = article.url;
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not open the article')),
                        );
                      }
                    },
                    child: ListTile(
                      title: Text(article.title),
                      subtitle: Text(article.description),
                      leading: Container(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'trendhaber.jpg',
                            image: article.urlToImage,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'trendhaber.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          ref.read(savedNewsProvider.notifier).removeArticle(article);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Article removed')),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}