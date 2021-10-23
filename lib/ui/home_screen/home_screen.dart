import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_reader/models/favorites.dart';
import 'package:novel_reader/models/search_book.dart';
import 'package:novel_reader/ui/book_screen/book_screen.dart';
import 'package:novel_reader/ui/search_screen/custom_search_delegate.dart';

part 'book_tile.dart';

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
              if (selectedBook != null) {
                Get.to(() => BookScreen(searchBook: selectedBook));
              }
            },
            icon: const Icon(Icons.search), //todo: replace with AnimatedIcon
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (Favorites.favBooks.isNotEmpty) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                ),
                itemCount: Favorites.favBooks.length,
                itemBuilder: (context, index) {
                  return BookTile(searchBook: Favorites.favBooks[index]);
                },
              );
            } else {
              return const Center(
                child: Text(
                  "Favorite books to appear here.",
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
