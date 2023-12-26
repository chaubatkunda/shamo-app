import 'package:flutter/material.dart';
import 'package:shamo_app/models/user_model.dart';
import 'package:shamo_app/services/auth_service.dart';

class AuthProvaider with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        email: email,
        username: username,
        password: password,
      );
      // print(name);
      _user = user;
      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
