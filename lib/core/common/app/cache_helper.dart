import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/extensions/theme_mode_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../singletons/cache.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _sessionTokenKey = 'user-session-token';
  static const _userIdKey = 'user-id';
  static const _themeModeKey = 'theme-mode';
  static const _firstTimerKey = 'is-user-first-timer';

 Future<bool> cacheSessionToken(String token) async {
  try {
    debugPrint("Saving Token: $token");
    final result = await _prefs.setString(_sessionTokenKey, token);
    Cache.instance.setSessionToken(token);
    debugPrint("Token Saved Successfully: ${getSessionToken()}");
    return result;
  } catch (e) {
    debugPrint("Error Saving Token: $e");
    return false;
  }
}


  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _prefs.setString(_userIdKey, userId);
      Cache.instance.setUserId(userId);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }

  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.stringValue);
    Cache.instance.setThemeMode(themeMode);
  }

String? getSessionToken() {
  final sessionToken = _prefs.getString(_sessionTokenKey);
  debugPrint("Session Token retrieved: $sessionToken");
  if (sessionToken != null) {
    Cache.instance.setSessionToken(sessionToken);
  }
  return sessionToken;
}


  String? getUserId() {
    final userId = _prefs.getString(_userIdKey);
    if (userId case String()) {
      Cache.instance.setUserId(userId);
    }
    return userId;
  }

  ThemeMode getThemeMode() {
    final themeModeStringValue = _prefs.getString(_themeModeKey);
    final themeMode = themeModeStringValue?.toThemeMode ?? ThemeMode.system;
    Cache.instance.setThemeMode(themeMode);
    return themeMode;
  }

  Future<void> resetSession() async {
    await _prefs.remove(_sessionTokenKey);
    await _prefs.remove(_userIdKey);
    Cache.instance.resetSessionToken();
  }

  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;
}
