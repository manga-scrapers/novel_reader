import 'package:flutter/material.dart';
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/ui/home_screen/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Novel Reader",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.red.shade100,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          toolbarTextStyle: kAppBarTextStyle,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
