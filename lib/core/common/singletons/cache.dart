import 'package:flutter/material.dart';

//-- Singleton Pattern
class Cache {
  Cache._internal();
  static final Cache instance = Cache._internal();
  //1- Define Your Variables :- sessionToken, userId, themeMode
  String? _sessionToken;
  String? _userId;
  final themeModeNotifier = ValueNotifier(ThemeMode.system);
  //ValueNotifier ==> a class that can be used to notify listeners when a value changes.
  //2- Define Your Methods To Allow External Class Access To This Variables

  String? get sessionToken => _sessionToken;
  String? get userId => _userId;

void setSessionToken(String? newToken) {
  if (_sessionToken != newToken) {
    _sessionToken = newToken;
    debugPrint("Session token updated: $_sessionToken");
  }
}

  void setUserId(String? newUserId) {
    if (_userId != newUserId) _userId = newUserId;
  }

  void setThemeMode(ThemeMode newThemeMode) {
    if (themeModeNotifier.value != newThemeMode){
      themeModeNotifier.value = newThemeMode;
    }
     
  }

//reset Session Token
  void resetSessionToken() {
    setSessionToken(null);
    setUserId(null);
    setThemeMode(ThemeMode.system);
  }
}
