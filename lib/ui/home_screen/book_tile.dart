part of 'home_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: "${book.thumbnailLink}",
          useOldImageOnUrlChange: true,
          placeholder: (context, url) => const Icon(
            Icons.download,
            color: Colors.lightGreen,
          ),
        ),
        Text(
          "${book.name}",
          maxLines: 1,
        ),
        Text(
          "{${book.chaptersList.first}",
          maxLines: 1,
        ),
      ],
    );
  }
}
