import 'package:flutter/material.dart';
import 'package:social_media/models/user.dart';

class UserProvider with ChangeNotifier {
  Usuario? _usuario;

  Usuario get getUser => _usuario!;

  Future<void> refreshUser() async {}
}
