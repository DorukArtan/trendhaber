import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/models/article.dart';
import 'package:trendhaber/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedNewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedNews = ref.watch(savedNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: savedNews.isEmpty
          ? Center(child: Text('No saved news available'))
          : ListView.builder(
              itemCount: savedNews.length,
              itemBuilder: (context, index) {
                Article newsItem = savedNews[index];
                return GestureDetector(
                  onTap: () async {
                    final url = newsItem.url;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          newsItem.urlToImage,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'trendhaber.jpg',
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            newsItem.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            newsItem.description.isNotEmpty
                                ? newsItem.description
                                : 'No description available',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}