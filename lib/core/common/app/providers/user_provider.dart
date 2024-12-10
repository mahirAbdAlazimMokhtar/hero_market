import 'package:flutter/material.dart';
import 'package:hero_market/core/common/entities/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._internal();

  static final UserProvider instance = UserProvider._internal();
  User? _currentUser;

  User? get currentUSer => _currentUser;

  void setUser(User user) {
  if(_currentUser != user) {
    _currentUser = user;
  }
  }

}
