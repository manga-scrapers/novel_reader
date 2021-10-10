import 'dart:developer';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/models/search_book.dart';

class Scraper {
  static final Scraper _instance = Scraper._singleton();

  factory Scraper() {
    return _instance;
  }

  Scraper._singleton();

  final client = http.Client();

  //
  static Future<List<SearchBook>> getSearchBooksList(String query) async {
    query = _getFormattedQuery(query);
    List<SearchBook> list = [];

    var url = Uri.parse(kUrl + "search?keyword=" + query);

    var response = await http.get(url);

    if (response.statusCode != 200) {
      log("[-] Error in fetching search books list",
          error: response.statusCode);
      return Future.error(
          "[-] Error in fetching search books list: ${response.statusCode}");
    }

    // Logic

    var document = parse(response.body);

    var searchList = document
        .querySelector("#list-page")!
        .querySelector("div.list.list-novel")!
        .querySelectorAll("div.row");

    for (var eachItem in searchList) {
      var doc = parse(eachItem.innerHtml);

      var imgLink = doc.querySelector("img.cover")?.attributes['src']?.trim();

      var x = doc.querySelector("h3.novel-title > a");
      var bookName = x?.text.trim();
      var bookLink = x?.attributes['href']!.trim();

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

  static String _getFormattedQuery(String query) {
    return Uri.encodeFull(query.trim());
  }
}
