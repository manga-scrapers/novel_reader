import 'package:novel_reader/models/book_chapter.dart';

class Favorites {
  static final Favorites _instance = Favorites._singleton();

  factory Favorites() {
    return _instance;
  }

  Favorites._singleton();

  // List of books favorited
  static const List<Book> favBooks = [];

// periodically update book details

}
