import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trendhaber/models/article.dart';
import 'package:trendhaber/news_fetcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';
import 'package:trendhaber/providers/bookmark_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedPage extends ConsumerStatefulWidget {
  @override 
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  late Future<List<Article>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsFetcher().fetchTopNews();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles = ref.watch(savedNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Feeds'),
      ),
      body: FutureBuilder<List<Article>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            List<Article> newsItems = snapshot.data!;
            return CarouselSlider.builder(
              itemCount: newsItems.length,
              options: CarouselOptions(
                height: 650.0,
                autoPlay: false,
                enlargeCenterPage: true,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                Article newsItem = newsItems[index];
                bool isBookmarked = bookmarkedArticles.contains(newsItem);
                return GestureDetector(
                  onTap: () async {
                    final url = newsItem.url;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : const Color.fromARGB(255, 16, 8, 29),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'trendhaber.jpg',
                              image: newsItem.urlToImage,
                              fit: BoxFit.cover,
                              height: 400,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'trendhaber.jpg',
                                  fit: BoxFit.cover,
                                  height: 400,
                                );
                              },
                            ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                newsItem.title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? Colors.grey.shade500 : null,
                          ),
                          onPressed: () {
                            if (isBookmarked) {
                              ref.read(savedNewsProvider.notifier).removeArticle(newsItem);
                            } else {
                              ref.read(savedNewsProvider.notifier).addArticle(newsItem);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}