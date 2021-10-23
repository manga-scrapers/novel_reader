import 'package:get/get.dart';
import 'package:novel_reader/models/search_book.dart';

class Favorites {
  static final Favorites _instance = Favorites._singleton();

  factory Favorites() {
    return _instance;
  }

  Favorites._singleton();

  // List of books favorited
  static RxList<SearchBook> favBooks = <SearchBook>[].obs;

  // periodically update book details
  void updateBooksDetail() {
    throw UnimplementedError();
  }

  // Check if book is favorited
  static bool isFavorite(SearchBook sb) {
    // TODO: use hash-map instead.
    for (var b in favBooks) {
      if (b.bookLink == sb.bookLink) {
        return true;
      }
    }
    return false;
  }

  // Remove from [favBooks]
  static void removeFavorite(SearchBook sb) {
    favBooks.removeWhere((element) => element.bookLink == sb.bookLink);
  }
}
