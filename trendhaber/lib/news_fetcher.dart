import 'package:http/http.dart' as http;
import 'dart:convert';

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }

  bool hasEmptyFields() {
    return title.isEmpty || description.isEmpty || url.isEmpty || urlToImage.isEmpty;
  }
}

class NewsFetcher {
  String apiKey = '3e388ca8855641e0ad7c19677ad937ad';
  String baseUrl = 'https://newsapi.org/v2/';

  Future<List<Article>> fetchTopNews() async {
    String partialUrl = 'top-headlines?country=us&apiKey=$apiKey';
    String url = baseUrl + partialUrl;
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> articlesJson = jsonResponse['articles'];
        List<Article> articles = articlesJson.map((json) => Article.fromJson(json)).toList();
        articles = articles.where((article) => !article.hasEmptyFields()).toList();
        return articles.take(100).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

void main() async {
  NewsFetcher newsFetcher = NewsFetcher();
  List<Article> articles = await newsFetcher.fetchTopNews();
  for (var article in articles) {
    print('Title: ${article.title}');
    print('Description: ${article.description}');
    print('URL: ${article.url}');
    print('URL to Image: ${article.urlToImage}');
    print('');
  }
  print('hello');
}