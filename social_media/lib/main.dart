import 'package:flutter/material.dart';
import 'package:social_media/pages/main_page.dart';
import 'package:social_media/utils/cores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media',
      theme: ThemeData(
        scaffoldBackgroundColor: corBackground,
        colorScheme: const ColorScheme.dark(
          primary: corPrincipal,
          secondary: corSecundaria,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 54),
          headline2: TextStyle(fontSize: 42),
          headline3: TextStyle(fontSize: 30),
          headline4: TextStyle(fontSize: 22),
          headline5: TextStyle(fontSize: 16),
          headline6: TextStyle(fontSize: 11),
        ),
      ),
      home: MainPage(),
    );
  }
}
