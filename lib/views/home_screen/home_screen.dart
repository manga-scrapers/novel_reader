import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/views/search_screen/custom_search_delegate.dart';

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
