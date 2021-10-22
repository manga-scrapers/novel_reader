part of 'book_screen.dart';

class ChaptersListView extends StatelessWidget {
  const ChaptersListView(this.chaptersList, {Key? key}) : super(key: key);
  final List<Chapter> chaptersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chaptersList.length,
      itemBuilder: (context, index) {
        final chapter = chaptersList[index];
        return GFListTile(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          padding: const EdgeInsets.all(4.0),
          color: Colors.white.withOpacity(0.5),
          titleText: chapter.name,
          onTap: () {
            // TODO: implement this
            Get.to(() => ChapterView(chapter: chapter));
          },
        );
      },
    );
  }
}
