part of 'home_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({Key? key, required this.searchBook}) : super(key: key);
  final SearchBook searchBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 160,
      color: Colors.amber,
    );
  }
}
