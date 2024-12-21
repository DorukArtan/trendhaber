import 'package:riverpod/riverpod.dart';
import 'package:trendhaber/news_fetcher.dart';


final darkModeProvider = StateProvider<bool>((ref){
  return false;
});

class SavedNewsNotifier extends StateNotifier<List<Article>> {
  SavedNewsNotifier() : super([]);

  void addArticle(Article article) {
    state = [...state, article];
  }

  void removeArticle(Article article) {
    state = state.where((a) => a != article).toList();
  }
}

final savedNewsProvider = StateNotifierProvider<SavedNewsNotifier, List<Article>>((ref) {
  return SavedNewsNotifier();
});