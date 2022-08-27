import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/pages/screens/login_screen.dart';
import 'package:social_media/pages/screens/signup_screen.dart';
import 'package:social_media/utils/cores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoginScreen(),
    );
  }
}

// const ResponsiveLayout(
// webScreenLayout: WebScreenLayout(),
// mobileScreenLayout: MobileScreenLayout(),),