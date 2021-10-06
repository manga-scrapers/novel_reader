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
    return FutureBuilder<List<SearchBook>>(
      future: Scraper.getSearchBooksList(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
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
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
