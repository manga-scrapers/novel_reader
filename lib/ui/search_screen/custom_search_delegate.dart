import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/scraper.dart';
import 'package:novel_reader/ui/components/indicators.dart';

part 'search_book_tile.dart';

class CustomSearchDelegate extends SearchDelegate<SearchBook> {
  /// The client for downloading data
  final _client = GetHttpClient();

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
    return displaySearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return suggestionsView(context);
  }

  @override
  void close(BuildContext context, SearchBook result) {
    // close client
    _client.close();

    //
    super.close(context, result);
  }

  Widget suggestionsView(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Scraper.getSearchSuggestions(query),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var searchResults = snapshot.data!;
          return Column(
            children: [
              Visibility(
                visible: snapshot.connectionState != ConnectionState.done,
                child: const LinearProgressIndicator(
                  color: Colors.red,
                  backgroundColor: Colors.amber,
                ),
              ),
              Expanded(
                child: stackOfSuggestions(context, searchResults),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Stack stackOfSuggestions(BuildContext context, List<String> searchResults) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          color: Colors.grey,
          width: context.width,
          height: context.height,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
          child: Container(
            color: Colors.white.withOpacity(0),
            constraints: BoxConstraints(
              maxWidth: context.width * 0.75,
              maxHeight: context.height * 0.5,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var element = searchResults.elementAt(index);
                return Material(
                  elevation: 4.0,
                  child: ListTile(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: element));
                      GFToast.showToast(
                        "Copied",
                        context,
                        toastPosition: GFToastPosition.BOTTOM,
                      );
                    },
                    title: Text(
                      element,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      query = element;
                      showResults(context);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget displaySearchResults(BuildContext context) {
    return FutureBuilder<List<SearchBook>>(
      future: Scraper.getSearchBooksList(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return noMatchFoundWidget(context);
          }
          return searchResultsView(snapshot.data!, context);
        }

        if (snapshot.hasError) {
          log(
            "[-] Error in search delegate",
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );
          return Indicators.errorIndicator("Error in searching");
        }

        return Indicators.loadingProgressIndicator();
      },
    );
  }

  Widget noMatchFoundWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: context.width * 0.25,
          ),
          Text("No match found for '$query'"),
        ],
      ),
    );
  }

  Widget searchResultsView(List<SearchBook> data, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 4.0, left: 16.0, bottom: 4.0),
          color: Colors.green,
          width: context.width,
          child: Text(
            "Showing ${data.length} results",
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final sb = data[index];
              return SearchBookTile(sb, onPress: () {
                close(context, sb);
              });
            },
          ),
        ),
      ],
    );
  }
}
