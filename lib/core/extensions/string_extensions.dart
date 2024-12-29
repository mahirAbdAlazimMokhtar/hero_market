import 'package:flutter/material.dart';

extension StringExt on String {
  Map<String, String> get toAuthHeaders {
    return {
      'Authorization': 'Bearer $this',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  ThemeMode get toThemeMode {
    return switch (toLowerCase()) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  String get obscureEmail {
    // Ensure the email contains an '@' character
    final index = indexOf('@');
    if (index == -1) {
      throw FormatException('Invalid email format');
    }

    // Split the email into username and domain
    var username = substring(0, index);
    final domain = substring(index + 1);

    // Handle short usernames
    if (username.length <= 2) {
      return '$username@$domain';
    }

    // Obscure the username
    username = '${username[0]}****${username[username.length - 1]}';
    return '$username@$domain';
  }
}
