import 'dart:developer';

import 'package:get/get_connect.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/models/book_chapter.dart';
import 'package:novel_reader/models/search_book.dart';

class Scraper {
  static final Scraper _instance = Scraper._singleton();

  factory Scraper() {
    return _instance;
  }

  Scraper._singleton();

  static final client = GetHttpClient();

  /// Get books list for query [query]
  static Future<List<SearchBook>> getSearchBooksList(
    String query,
  ) async {
    query = _getFormattedQuery(query);
    List<SearchBook> list = [];
    var url = kUrl + "/search?keyword=" + query;

    var response = await client.get(url);

    if (response.statusCode != 200) {
      var errorMsg = "[-] Error in fetching search books list";
      log(errorMsg, error: response.statusCode);
      return Future.error("$errorMsg: ${response.statusCode}");
    }

    // Logic

    var document = parse(response.body);

    var searchList = document
        .querySelector("#list-page")!
        .querySelector("div.list.list-novel")!
        .querySelectorAll("div.row");

    for (var eachItem in searchList) {
      var doc = parse(eachItem.innerHtml);

      var x = doc.querySelector("h3.novel-title > a");
      var bookName = x?.text.trim();
      var bookLink = x?.attributes['href']!.trim();

      if (bookLink == null) continue;

      var imgLink = doc.querySelector("img.cover")?.attributes['src']?.trim();

      var author = doc.querySelector("span.author")?.text.trim();

      var latestChapterName =
          doc.querySelector("a > span.chr-text")?.text.trim();

      var sb = SearchBook(
        name: bookName,
        bookLink: bookLink,
        latestChapterInfo: latestChapterName,
        thumbnailLink: imgLink,
        author: author,
      );
      // log("[+] scraper.dart: " + sb.toString());
      list.add(sb);
    }

    return list;
  }

  /// Get search suggestions for [query]
  static Future<List<String>> getSearchSuggestions(String query) async {
    query = _getFormattedQuery(query);
    if (query.length < 3) {
      return [];
    }
    var url = kUrl + "/ajax/search-novel?keyword=$query";
    var response = await client.get(url);
    if (response.statusCode != 200) {
      log("[-] Error in suggestions: ", error: response.statusCode);
      return Future.error(
          "[-] Error in suggestions: ${response.status.toString()}");
    }

    var doc = parse(response.body);
    List<String> results = [];
    var e = doc.querySelectorAll("a");
    for (int i = 0; i < e.length - 1; i++) {
      results.add(e[i].text.trim());
    }
    return results;
  }

  /// Get [Book] from [SearchBook] obtained in [getSearchBooksList]
  static Future<Book> getBook(SearchBook searchBook) async {
    String bookLink = searchBook.bookLink.contains(kUrl)
        ? searchBook.bookLink
        : kUrl + searchBook.bookLink;

    Response response = await client.get(bookLink);

    if (response.statusCode != 200) {
      log("[-] Error fetching book: ",
          error: "${response.statusCode} (${response.status})");
      return Future.error(
          "[-] Error fetching book: ${response.statusCode} (${response.status})");
    }

    var document = parse(response.body, sourceUrl: bookLink);

    String bookName =
        document.querySelector("h3.title[itemprop=name]")!.text.trim();

    String bookAuthor = document
        .querySelectorAll("ul.info.info-meta > li")[1]
        .querySelectorAll("a")
        .map((e) => e.text.trim())
        .join(" , ");

    String bookThumbnailLink = document
        .querySelector("div.books > div.book > img[src][alt]")!
        .attributes["src"]!
        .trim();

    List<String> bookGenres = document
        .querySelectorAll("ul.info.info-meta > li")[2]
        .querySelectorAll("a")
        .map((e) => e.text.trim())
        .toList();

    double ratingValue = double.tryParse(document
            .querySelector("span[itemprop=ratingValue]")!
            .text
            .trim()) ??
        -1.0;
    double bestRating = double.tryParse(
            document.querySelector("span[itemprop=bestRating]")!.text.trim()) ??
        10;
    double bookRating = (ratingValue / bestRating) * 10;

    String bookDescription =
        document.querySelector("#tab-description")!.text.trim();

    String bookStatus = document
        .querySelectorAll("ul.info.info-meta > li")
        .last
        .querySelector("a.text-primary")!
        .text
        .trim();

    String bookLastChapterUpdateTime = document
        .querySelector("div.l-chapter > div.item > div.item-time")!
        .text
        .trim();

    List<Chapter> bookChaptersList = await _getChaptersList(document, client);

    return Book(
      name: bookName,
      author: bookAuthor,
      thumbnailLink: bookThumbnailLink,
      chaptersList: bookChaptersList,
      genres: bookGenres,
      rating: bookRating,
      bookLink: bookLink,
      description: bookDescription,
      status: bookStatus,
      lastChapterUpdateTime: bookLastChapterUpdateTime,
    );
  }

  static Future<List<Chapter>> _getChaptersList(
      Document doc, GetHttpClient client) async {
    List<Chapter> chaptersList = [];

    var novelId =
        doc.querySelector("div[data-novel-id]")?.attributes["data-novel-id"];
    var newUrl =
        "https://readnovelfull.com/ajax/chapter-archive?novelId=$novelId";

    var response = await client.get(newUrl);
    if (response.statusCode != 200) {
      log("[-] Error in fetching chapters list: ", error: response.status);
      return Future.error(
          "[-] Error in fetching chapters list: ${response.statusCode}");
    }

    doc = parse(response.body);
    var e = doc.querySelectorAll("a");
    for (var a in e) {
      // TODO(p2kr) : error handling
      var link = kUrl + (a.attributes['href'])!;
      var name = a.text.trim();
      var chapter = Chapter(
        name: name,
        chapterLink: link.trim(),
      );
      chaptersList.add(chapter);
    }

    return chaptersList;
  }

  static Future<String?> getChapterText(Chapter chapter) async {
    var response = await client.get(chapter.chapterLink);
    if (response.statusCode != 200) {
      var msg = "[-] Error in getChapterText: ";
      log(msg, error: response.status);
      return Future.error("$msg ${response.statusCode}");
    }

    var doc = parse(response.body);

    var text = doc.getElementById("chr-content")?.innerHtml;

    return text?.trim();
  }

  static String _getFormattedQuery(String query) {
    return Uri.encodeFull(query.trim());
  }
}
