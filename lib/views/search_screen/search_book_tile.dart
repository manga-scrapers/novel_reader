part of 'custom_search_delegate.dart';

class SearchBookTile extends StatelessWidget {
  final SearchBook book;

  final void Function()? onPress;

  const SearchBookTile(this.book, {Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade100,
      margin: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "${book.thumbnailLink}",
                fit: BoxFit.fill,
                placeholder: (context, url) => const Icon(Icons.downloading),
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${book.name}",
                  ),
                  Text(
                    "${book.author}",
                    style: context.textTheme.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              flex: 2,
              child: Text("${book.latestChapterInfo}"),
            ),
          ],
        ),
      ),
    );
  }
}
