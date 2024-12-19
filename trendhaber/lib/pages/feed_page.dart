import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeedPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: CarouselSlider.builder(
        itemCount: newsItems.length,
        options: CarouselOptions(
          height: 400.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final newsItem = newsItems[index];
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