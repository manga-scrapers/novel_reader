class Book {
  String? name;
  String? author;
  String? thumbnailLink;
  List<Chapter> chaptersList;
  List<String> genres;
  double rating;
  String? bookLink;

  Book({
    this.name,
    this.author,
    this.thumbnailLink,
    this.chaptersList = const [],
    this.genres = const [],
    this.rating = 0.0,
    this.bookLink,
  }) {
    name = name?.trim();
    author = author?.trim();
    thumbnailLink = thumbnailLink?.trim();
    for (int i = 0; i < genres.length; i++) {
      genres[i].trim();
    }
    bookLink = bookLink?.trim();
  }

  /// Get [rating] formatted to 2 decimal places.
  String getRatingFormatted() {
    return rating.toStringAsFixed(2);
  }

  /// Get [genres] formatted as single string.
  String getGenresFormatted() {
    var genresFormatted = StringBuffer("");
    for (int i = 0; i < genres.length; i++) {
      genresFormatted.write(genres[i]);
      if (i < genres.length - 1) {
        genresFormatted.write(" , ");
      }
    }
    return genresFormatted.toString();
  }
}

class Chapter {
  String? name;
  double pageNumber;
  String? chapterLink;
  String? text;

  Chapter({this.name, this.pageNumber = 0.0, this.chapterLink, this.text}) {
    name = name?.trim();
    chapterLink = chapterLink?.trim();
    text = text?.trim();
  }

  bool wasRead() {
    return pageNumber > 0.0;
  }
}
