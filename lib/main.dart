import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:novel_reader/constants.dart';
import 'package:novel_reader/ui/home_screen/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
        Get.put(
          GetHttpClient(),
          tag: "client",
          permanent: true,
        );
      },
      onDispose: () {
        Get.find<GetHttpClient>().close();
      },
    );
  }
}
