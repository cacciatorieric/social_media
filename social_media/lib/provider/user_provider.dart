import 'package:flutter/material.dart';
import 'package:social_media/backend/auth_methods.dart';
import 'package:social_media/models/user.dart';

class UserProvider with ChangeNotifier {
  Usuario _usuario = const Usuario(
    username: '',
    uid: '',
    email: '',
    bio: '',
    followers: [],
    following: [],
    photoUrl: '',
  );
  final AuthMethods _authMethods = AuthMethods();

  Usuario get getUser => _usuario;
  Future<void> refreshUser() async {
    Usuario usuario = await _authMethods.getUserDetails();
    _usuario = usuario;
    notifyListeners();
  }
}
