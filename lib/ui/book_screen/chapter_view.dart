part of 'book_screen.dart';

class ChapterView extends StatelessWidget {
  const ChapterView({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.name),
      ),
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: Scraper.getChapterText(chapter),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Html(
                  data: snapshot.data,
                ),
              );
            }
            if (snapshot.hasError) {
              return Indicators.errorIndicator(snapshot.error.toString());
            }
            return Indicators.loadingProgressIndicator();
          },
        ),
      ),
    );
  }
}
