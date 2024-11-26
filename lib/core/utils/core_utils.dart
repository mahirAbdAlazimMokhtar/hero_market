import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';

abstract class CoreUtils {
  const CoreUtils();

  static Color adaptiveColor(
    BuildContext context, {
    required Color lightModeColor,
    required Color darkModeColor,
  }) {
    return context.isDarkMode ? darkModeColor : lightModeColor;
  }
}
