import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? Container(
              color: Colors.blueAccent,
              child: const Center(
                child: Text('Tela Principal'),
              ),
            )
          : Container(
              color: Colors.greenAccent,
              child: const Center(
                child: Text('Tela Principal'),
              ),
            ),
    );
  }
}
