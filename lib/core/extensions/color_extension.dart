

import 'dart:ui';

extension ColorExtensions on Color {
  String get hex {
    return toString().substring(8, 16).toLowerCase().replaceFirst('ff', '#');
  }
}
