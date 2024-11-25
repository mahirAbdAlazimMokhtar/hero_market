
import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';

abstract class CoreUtils {
  const CoreUtils();

  static Color adaptiveColor(
    BuildContext context, {
    required Color lightColor,
    required Color darkColor, 
  }) {
    return  context.isDarkMode ? darkColor : lightColor;
  }
}
