import 'dart:math';

import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('dasdad'),
          onPressed: () {
            String palavra1 = getRandomString(350);
            print(palavra1);
          },
        ),
      ),
    );
  }
}
