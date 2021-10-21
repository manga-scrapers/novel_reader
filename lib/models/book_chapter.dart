import 'dart:developer';

class Book {
  String name;
  String author;
  String thumbnailLink;
  List<Chapter> chaptersList;
  List<String> genres;
  double rating;
  String bookLink;
  String description;
  String? status;
  String lastChapterUpdateTime;

  Book({
    required this.name,
    required this.author,
    required this.thumbnailLink,
    this.chaptersList = const [],
    this.genres = const [],
    this.rating = 0.0,
    required this.bookLink,
    this.description = "",
    this.status,
    this.lastChapterUpdateTime = "",
  }) {
    name = name.trim();
    author = author.trim();
    thumbnailLink = thumbnailLink.trim();
    for (int i = 0; i < genres.length; i++) {
      genres[i].trim();
    }
    bookLink = bookLink.trim();
    description = description.trim();
    status = status?.trim();
  }

  /// Get [rating] formatted to 2 decimal places.
  String getRatingFormatted() {
    return rating.toStringAsFixed(2);
  }

  /// Get [genres] formatted as single string.
  String getGenresFormatted() {
    return genres.join(" , ");
  }

  /// Verify [Book]'s parameters
  bool verify() {
    var verified = true;

    try {
      Uri.parse(bookLink);
    } catch (e) {
      log("[-] Invalid bookLink: ", error: e);
      return false;
    }

    try {
      Uri.parse(thumbnailLink);
    } catch (e) {
      log("[-] Invalid thumbnailLink: ", error: e);
      return false;
    }

    return verified;
  }
}

class Chapter {
  String name;
  double pageNumber;
  String chapterLink;
  String? text;

  Chapter({
    required this.name,
    this.pageNumber = 0.0,
    required this.chapterLink,
    this.text,
  }) {
    name = name.trim();
    chapterLink = chapterLink.trim();
    text = text?.trim();
  }

  bool wasRead() {
    return pageNumber > 0.0;
  }

  /// Verify [Chapter]'s parameters
  bool verify() {
    bool verified = true;

    try {
      Uri.parse(chapterLink);
    } catch (e) {
      log("[-] Invalid chapterLink: ", error: e);
      return false;
    }

    return verified;
  }
}
