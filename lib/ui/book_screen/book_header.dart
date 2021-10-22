part of 'book_screen.dart';

class BookScreenHeader extends StatelessWidget {
  const BookScreenHeader(this.book, {Key? key}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 4.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                book.name,
                maxLines: 2,
                style: context.textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Author: ${book.author}",
                maxLines: 1,
                style: context.textTheme.subtitle2,
              ),
              Text("Genres: ${book.getGenresFormatted()}", maxLines: 1),
              Text("Rating: ${book.getRatingFormatted()}", maxLines: 1),
              Text("Status: ${book.status}", maxLines: 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scrollableText(String msg, {TextStyle? style}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        msg,
        style: style,
      ),
    );
  }
}
