import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/models/book_chapter.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';
import 'package:novel_reader/ui/components/indicators.dart';

part 'chapters_list.dart';

part 'header.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key, required this.sb}) : super(key: key);
  final SearchBook sb;

  final _client =
      Get.find<GetHttpClient>(tag: "client"); // todo: where to close() this?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          child: Text(sb.name ?? "Book"),
        ),
      ),
      body: FutureBuilder<Book>(
          future: Scraper.getBook(sb, _client),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              // _client.close();
              return Column(
                children: [
                  Expanded(child: BookScreenHeader(snapshot.data!)),
                  Expanded(
                    flex: 2,
                    child: ChaptersListView(snapshot.data!.chaptersList),
                  )
                ],
              );
            }
            return Indicators.loadingProgressIndicator();
          }),
    );
  }
}
