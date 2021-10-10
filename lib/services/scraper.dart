import 'dart:developer';

import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/models/search_book.dart';

class Scraper {
  static final Scraper _instance = Scraper._singleton();

  factory Scraper() {
    return _instance;
  }

  Scraper._singleton();

  //
  static Future<List<SearchBook>> getSearchBooksList(
    String query,
    GetHttpClient client,
  ) async {
    query = _getFormattedQuery(query);
    List<SearchBook> list = [];

    var url = kUrl + "search?keyword=" + query;

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
