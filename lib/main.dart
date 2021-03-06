import 'package:flutter/material.dart';
import 'package:ibdaa/ui/introPage/introPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale('ar', ''),
        debugShowCheckedModeBanner: false,
        title: 'Ibdaa',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: IntroPage(),
        ));
  }
}
