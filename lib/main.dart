import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/services/scraper.dart';
import 'package:novel_reader/ui/home_screen/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Novel Reader",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.red.shade100,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          toolbarTextStyle: kAppBarTextStyle,
        ),
      ),
      home: const HomeScreen(),
      onInit: () {
        // Check if client is successfully active
      },
      onDispose: () {
        // Close client
        Scraper.client.close();
      },
    );
  }
}
