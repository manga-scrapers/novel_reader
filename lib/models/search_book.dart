import 'dart:convert';

class SearchBook {
  String? name;
  String bookLink;
  String? thumbnailLink;
  String? latestChapterInfo;
  String? author;

  SearchBook({
    this.name,
    required this.bookLink,
    this.thumbnailLink,
    this.latestChapterInfo,
    this.author,
  }) {
    name = name?.trim();
    bookLink = bookLink.trim();
    thumbnailLink = thumbnailLink?.trim();
    latestChapterInfo = latestChapterInfo?.trim();
    author = author?.trim();
  }

  @override
  String toString() {
    return jsonEncode({
      'name': name,
      'bookLink': bookLink,
      'thumbnailLink': thumbnailLink,
      'latestChapterInfo': latestChapterInfo,
      'author': author,
    });
  }
}
