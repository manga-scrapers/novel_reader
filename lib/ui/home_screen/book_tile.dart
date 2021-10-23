part of 'home_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({Key? key, required this.searchBook}) : super(key: key);
  final SearchBook searchBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the book
        Get.to(() => BookScreen(searchBook: searchBook));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: searchBook.thumbnailLink ?? "",
                useOldImageOnUrlChange: true,
                placeholder: (context, url) {
                  return const Icon(Icons.download);
                },
              ),
            ),
            Text(
              searchBook.name ?? "??",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              searchBook.latestChapterInfo ?? "??",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
