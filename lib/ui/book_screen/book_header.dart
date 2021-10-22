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
                overflow: TextOverflow.ellipsis,
              ),
              _labelAndText("Author: ", book.author, context),
              _labelAndText(
                "Genres: ",
                book.getGenresFormatted(),
                context,
                toolTip: true,
              ),
              _labelAndText("Rating: ", book.getRatingFormatted(), context),
              if (book.status != null)
                _labelAndText("Status: ", book.status!, context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labelAndText(
    String label,
    String text,
    BuildContext context, {
    bool toolTip = false,
  }) {
    final Text labelWidget = Text(
      label,
      style: context.textTheme.subtitle2?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
    final Text textWidget = Text(
      text,
      maxLines: 2,
      style: context.textTheme.subtitle2,
      overflow: TextOverflow.ellipsis,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelWidget,
        Expanded(
          child: toolTip
              ? Tooltip(
                  waitDuration: const Duration(seconds: 1),
                  triggerMode: TooltipTriggerMode.longPress,
                  message: text,
                  child: textWidget,
                )
              : textWidget,
        )
      ],
    );
  }
}
