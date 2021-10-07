import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/services/custom_search_delegate.dart';

part 'search_book_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        actions: [
          IconButton(
            onPressed: () async {
              // show search
              var selectedBook = await showSearch<SearchBook>(
                  context: context, delegate: CustomSearchDelegate());
              log("$selectedBook");
            },
            icon: const Icon(Icons.search), //todo: replace with AnimatedIcon
          ),
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
