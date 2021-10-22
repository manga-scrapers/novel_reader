import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/models/book_chapter.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';
import 'package:novel_reader/ui/components/indicators.dart';

part 'book_header.dart';
part 'chapters_list.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key, required this.searchBook}) : super(key: key);
  final SearchBook searchBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: searchBook.name ?? "Book",
          triggerMode: TooltipTriggerMode.longPress,
          child: Text(
            searchBook.name ?? "Book",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Book>(
            future: Scraper.getBook(searchBook),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final Book book = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      BookScreenHeader(book),
                      const SizedBox(height: 4.0),
                      Expanded(
                        child: ChaptersListView(book.chaptersList),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                log(
                  "[-] Error in book_tile : ",
                  error: snapshot.error,
                  stackTrace: snapshot.stackTrace,
                );
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error),
                      Text("Error in fetching book"),
                    ],
                  ),
                );
              }
              return Indicators.shimmerProgressIndicator(context);
            }),
      ),
    );
  }
}
