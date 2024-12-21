import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trendhaber/news_fetcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/provider.dart';
import 'package:trendhaber/providers/bookmark_provider.dart';

class FeedPage extends ConsumerStatefulWidget {
  @override 
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  List<Article> newsItems = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    List<Article> fetchedNews = await NewsFetcher().fetchTopNews();
    setState(() {
      newsItems = fetchedNews;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkedIndices = ref.watch(bookmarkedProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Feeds'),
      ),
      body: newsItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : CarouselSlider.builder(
              itemCount: newsItems.length,
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                Article newsItem = newsItems[index];
                bool isBookmarked = bookmarkedIndices.contains(index);
                return Stack(
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
                          Image.network(
                            newsItem.urlToImage,
                            fit: BoxFit.cover,
                            height: 300,
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
                          color: isBookmarked ? Colors.black : null,
                        ),
                        onPressed: () {
                          ref.read(bookmarkedProvider.notifier).toggleBookmark(index);
                          bool updatedIsBookmarked = !isBookmarked;
                          if (!updatedIsBookmarked) {
                            ref.read(savedNewsProvider.notifier).removeArticle(newsItem);
                          } else {
                            ref.read(savedNewsProvider.notifier).addArticle(newsItem);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}