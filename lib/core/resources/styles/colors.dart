import 'package:flutter/material.dart';

import '../../utils/core_utils.dart';

abstract class AppColors {
  // lightThemePrimaryTint Color Swatch
  static const Color lightThemePrimaryTint = Color(0xff9e9cdc);

  // lightThemePrimaryColor Color Swatch
  static const Color lightThemePrimaryColor = Color(0xff524eb7);

  // lightThemeSecondaryColor Color Swatch
  static const Color lightThemeSecondaryColor = Color(0xfff76631);

  // lightThemePrimaryTextColor Color Swatch
  static const Color lightThemePrimaryTextColor = Color(0xff282344);

  // lightThemeSecondaryTextColor Color Swatch
  static const Color lightThemeSecondaryTextColor = Color(0xff9491a1);

  // lightThemePinkColor Color Swatch
  static const Color lightThemePinkColor = Color(0xfff08e98);

  // lightThemeWhiteColor Color Swatch
  static const Color lightThemeWhiteColor = Color(0xffffffff);

  // lightThemeTintStockColor Color Swatch
  static const Color lightThemeTintStockColor = Color(0xfff6f6f9);

  // lightThemeYellowColor Color Swatch
  static const Color lightThemeYellowColor = Color(0xfffec613);

  // lightThemeStockColor Color Swatch
  static const Color lightThemeStockColor = Color(0xffe4e4e9);

  // darkThemeDarkSharpColor Color Swatch
  static const Color darkThemeDarkSharpColor = Color(0xff191821);

  // darkThemeBGDark Color Swatch
  static const Color darkThemeBGDark = Color(0xff0e0d11);

  // darkThemeDarkNavBarColor Color Swatch
  static const Color darkThemeDarkNavBarColor = Color(0xff201f27);

  static Color classicAdaptiveTextColor(BuildContext context) =>
      CoreUtils.adaptiveColor(
        context,
        lightModeColor: lightThemePrimaryColor,
        darkModeColor: lightThemeWhiteColor,
      );
}
