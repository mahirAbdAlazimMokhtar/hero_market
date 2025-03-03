import 'package:flutter/material.dart';
import 'package:hero_market/core/common/entities/user.dart';

class UserProvider extends ChangeNotifier {

  User? _currentUser;

  User? get currentUSer => _currentUser;

  void setUser(User? user) {
    if (_currentUser != user) {
      _currentUser = user;
    }
  }

  void updateUser(User user) {
    //if condition
    if (_currentUser != user) {
      _currentUser = user;
    }
  }
}
