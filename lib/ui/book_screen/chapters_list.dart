part of 'book_screen.dart';

class ChaptersListView extends StatelessWidget {
  const ChaptersListView(this.chaptersList, {Key? key}) : super(key: key);
  final List<Chapter> chaptersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chaptersList.length,
      itemBuilder: (context, index) {
        var chapter = chaptersList[index];
        return ListTile(
          title: Text(chapter.name),
        );
      },
    );
  }
}
