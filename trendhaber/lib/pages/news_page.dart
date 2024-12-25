import 'package:flutter/material.dart';
import 'package:trendhaber/news_fetcher.dart';

class NewsPage extends StatefulWidget {
  final Article article;

  NewsPage({required this.article});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      //Adjustments
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9, 
              child: FadeInImage.assetNetwork(
                //Our logo
                placeholder: 'trendhaber.jpg',
                image: widget.article.urlToImage,
                fit: BoxFit.contain,
                height: 200,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'trendhaber.jpg',
                    //Adjustments for logo
                    fit: BoxFit.contain,
                    height: 200,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.article.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.article.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              //To be able to scroll we need SingleChildScrollView
              child: SingleChildScrollView(
                child: Text(
                  widget.article.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}