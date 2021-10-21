part of 'book_screen.dart';

class BookScreenHeader extends StatelessWidget {
  const BookScreenHeader(this.book, {Key? key}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: book.thumbnailLink,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 4.0),
        Column(
          children: [
            Text(book.name, maxLines: 1),
            Text("Author: ${book.author}", maxLines: 1),
            Text("Genres: ${book.getGenresFormatted()}", maxLines: 1),
            Text("Rating: ${book.getRatingFormatted()}", maxLines: 1),
            Text("Status: ${book.status}", maxLines: 1),
          ],
        ),
      ],
    );
  }
}
