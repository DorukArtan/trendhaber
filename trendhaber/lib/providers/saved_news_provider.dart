import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trendhaber/models/article.dart';

class SavedNewsNotifier extends Notifier<List<Article>> {
  @override
  List<Article> build() {
    return [];
  }

  void addArticle(Article article) {
    state = [...state, article];
  }

  void removeArticle(Article article) {
    state = state.where((a) => a.url != article.url).toList();
  }
}
final savedNewsProvider = NotifierProvider<SavedNewsNotifier, List<Article>>(() {
  return SavedNewsNotifier();
});