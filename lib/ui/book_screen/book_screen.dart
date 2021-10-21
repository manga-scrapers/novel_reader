import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novel_reader/models/book_chapter.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';
import 'package:novel_reader/ui/components/indicators.dart';

part 'chapters_list.dart';
part 'header.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key, required this.sb}) : super(key: key);
  final SearchBook sb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          child: Text(sb.name ?? "Book"),
        ),
      ),
      body: FutureBuilder<Book>(
          future: Scraper.getBook(sb),
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
