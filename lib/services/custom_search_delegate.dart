import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';

class CustomSearchDelegate extends SearchDelegate<SearchBook> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // clear the query
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().length < 3) {
      return const Center(
        child: Text("query size >= 3"),
      );
    }

    return FutureBuilder<List<SearchBook>>(
      future: Scraper.getSearchBooksList(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          // log(snapshot.data.toString());

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final sb = snapshot.data![index];
              return ListTile(
                title: Text("${sb.name}"),
                leading: Image.network("${sb.thumbnailLink}"),
                trailing: Text("${sb.latestChapterInfo}"),
              );
            },
          );
        }

        if (snapshot.hasError) {
          log("[-] Error in search delegate");
          return Center(
            child: Column(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text("${snapshot.error}"),
              ],
            ),
          );
        }

        return const LinearProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.amber,
        );
      },
    );
  }
}
