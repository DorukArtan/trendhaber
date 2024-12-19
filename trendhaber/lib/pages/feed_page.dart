import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeedPage extends StatefulWidget {
  @override 
  _FeedPageState createState() => _FeedPageState();

  final List<Map<String, String>> newsItems = [
    {
      'title': 'News Title 1',
      'image': 'https://via.placeholder.com/600x400',
    },
    {
      'title': 'News Title 2',
      'image': 'https://via.placeholder.com/600x400',
    },
    {
      'title': 'News Title 3',
      'image': 'https://via.placeholder.com/600x400',
    },
  ];
}
class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feeds'),
      ),
      body: CarouselSlider.builder(
        itemCount: widget.newsItems.length,
        options: CarouselOptions(
          height: 400.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          Map<String,String> newsItem = widget.newsItems[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              children: [
                Image.network(
                  newsItem['image']!,
                  fit: BoxFit.cover,
                  height: 300,
                ),
                SizedBox(height: 10),
                Text(
                  newsItem['title']!,
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