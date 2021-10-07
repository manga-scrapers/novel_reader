import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';

class CustomSearchDelegate extends SearchDelegate<SearchBook> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          // show result
          showResults(context);
        },
      ),
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
    if (query.trim().length < 3) {
      return const Center(
        child: Text("Query length must be >= 3"),
      );
    }

    return FutureBuilder<List<SearchBook>>(
      future: Scraper.getSearchBooksList(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          // log(snapshot.data.toString());
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("No match found for '$query'"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final sb = snapshot.data![index];
              return ListTile(
                title: Text(
                  "${sb.name}",
                  maxLines: 1,
                ),
                leading: Image.network("${sb.thumbnailLink}"),
                trailing: Text(
                  "${sb.latestChapterInfo}",
                  maxLines: 1,
                ),
                onTap: () {
                  close(context, sb);
                },
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

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().length < 3) {
      return const Center(
        child: Text("Query length must be >= 3"),
      );
    }
    return Container();
  }
}
