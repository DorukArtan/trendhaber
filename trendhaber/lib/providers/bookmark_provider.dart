import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkedNotifier extends StateNotifier<Set<int>> {
  BookmarkedNotifier() : super({});

  void toggleBookmark(int index) {
    if (state.contains(index)) {
      state = {...state}..remove(index);
    } else {
      state = {...state}..add(index);
    }
  }
}

final bookmarkedProvider = StateNotifierProvider<BookmarkedNotifier, Set<int>>((ref) {
  return BookmarkedNotifier();
});