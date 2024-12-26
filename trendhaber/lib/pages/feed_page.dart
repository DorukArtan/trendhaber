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
    final bookmarkedIndices = ref.watch(bookmarkedProvider);

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
                height: 400.0,
                autoPlay: false,
                enlargeCenterPage: true,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                Article newsItem = newsItems[index];
                bool isBookmarked = bookmarkedIndices.contains(index);
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
                        ),
                        child: Column(
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'trendhaber.jpg',
                              image: newsItem.urlToImage,
                              fit: BoxFit.cover,
                              height: 300,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'trendhaber.jpg',
                                  fit: BoxFit.cover,
                                  height: 300,
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              newsItem.title,
                              style: TextStyle(fontSize: 16.0),
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
                            setState(() {
                              if (isBookmarked) {
                                ref.read(savedNewsProvider.notifier).removeArticle(newsItem);
                              } else {
                                ref.read(savedNewsProvider.notifier).addArticle(newsItem);
                              }
                              ref.read(bookmarkedProvider.notifier).toggleBookmark(index);
                            });
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