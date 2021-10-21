import 'package:novel_reader/models/search_book.dart';

class Favorites {
  static final Favorites _instance = Favorites._singleton();

  factory Favorites() {
    return _instance;
  }

  Favorites._singleton();

  // List of books favorited
  static const List<SearchBook> favBooks = [];

// periodically update book details

}
