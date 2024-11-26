import 'package:flutter/material.dart';
import 'package:hero_market/core/resources/styles/colors.dart';

extension TextStyleExt on TextStyle {
  TextStyle get orange => copyWith(color: AppColors.lightThemeSecondaryColor);
    TextStyle get dark => copyWith(color: AppColors.lightThemePrimaryTextColor);

  TextStyle get grey => copyWith(color: AppColors.lightThemeSecondaryTextColor);

  TextStyle get white => copyWith(color: AppColors.lightThemeWhiteColor);

  TextStyle get primary => copyWith(color: AppColors.lightThemePrimaryColor);

  TextStyle adaptiveColor(BuildContext context) =>
      copyWith(color: AppColors.classicAdaptiveTextColor(context));
}
