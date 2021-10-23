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
                child: InteractiveViewer(
                  child: Html(
                    data: snapshot.data,
                    onImageError: (exception, stackTrace) {
                      log(
                        "Error loading html image: ",
                        error: exception,
                        stackTrace: stackTrace,
                      );
                    },
                    customImageRenders: {
                      networkSourceMatcher(): networkImageRender(
                        headers: {
                          "Referer": "https://readnovelfull.com/",
                          "User-Agent": kUserAgent
                        },
                        altWidget: (alt) => Text(alt ?? ""),
                        loadingWidget: () => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SpinKitRotatingCircle(
                            size: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    },
                  ),
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
