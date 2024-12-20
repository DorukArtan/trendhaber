import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trendhaber/news_fetcher.dart';

class FeedPage extends StatefulWidget {
  @override 
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
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
                );
              },
            ),
    );
  }
}