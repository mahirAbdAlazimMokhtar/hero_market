import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';

import '../resources/styles/colors.dart';

abstract class CoreUtils {
  const CoreUtils();
  static void showSnackBar(
    BuildContext context,{
    required String message,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor ?? AppColors.lightThemePrimaryColor,
      content: Center(
        child: Text(
          message,
          style: AppTextStyles.paragraphSubTextRegular1.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color adaptiveColor(
    BuildContext context, {
    required Color lightModeColor,
    required Color darkModeColor,
  }) {
    return context.isDarkMode ? darkModeColor : lightModeColor;
  }
}
