part of 'home_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({Key? key, required this.searchBook}) : super(key: key);
  final SearchBook searchBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          searchBook.name ?? "Book",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Book>(
            future: Scraper.getBook(searchBook),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final Book book = snapshot.data!;
                return Column(
                  children: [
                    CachedNetworkImage(
                      height: 160,
                      width: 90,
                      imageUrl: book.thumbnailLink,
                      useOldImageOnUrlChange: true,
                      placeholder: (context, url) => const Icon(
                        Icons.download,
                        color: Colors.lightGreen,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: book.chaptersList.length,
                        itemBuilder: (context, index) {
                          final chapter = book.chaptersList[index];
                          return ListTile(
                            tileColor:
                                index % 2 == 0 ? Colors.white : Colors.grey,
                            title: Text(chapter.name),
                            onTap: () {
                              // TODO: implement this
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                log(
                  "[-] Error in book_tile : ",
                  error: snapshot.error,
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
