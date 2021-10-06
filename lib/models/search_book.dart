class SearchBook {
  String? name;
  String? bookLink;
  String? thumbnailLink;
  String? latestChapterInfo;
  String? author;

  SearchBook({
    this.name,
    this.bookLink,
    this.thumbnailLink,
    this.latestChapterInfo,
    this.author,
  }) {
    name = name?.trim();
    bookLink = bookLink?.trim();
    thumbnailLink = thumbnailLink?.trim();
    latestChapterInfo = latestChapterInfo?.trim();
    author = author?.trim();
  }
}
