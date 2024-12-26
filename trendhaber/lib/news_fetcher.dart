import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trendhaber/models/article.dart';
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
        return articles.take(20).toList();
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