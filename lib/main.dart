// ignore_for_file: avoid_unnecessary_containers


import 'package:flutter/material.dart';

import 'core/resources/styles/colors.dart';
import 'core/resources/styles/text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme:
          ColorScheme.fromSeed(seedColor: AppColors.lightThemePrimaryColor),
      fontFamily: 'Switzer',
      scaffoldBackgroundColor: AppColors.lightThemeTintStockColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightThemeTintStockColor,
          foregroundColor: AppColors.lightThemePrimaryColor),
      useMaterial3: true,
    );
    return MaterialApp(
        title: 'Hero Market App',
        themeMode: ThemeMode.system,
        theme: theme,
        darkTheme: theme.copyWith(
          scaffoldBackgroundColor: AppColors.darkThemeBGDark,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.darkThemeBGDark,
            foregroundColor: AppColors.lightThemeWhiteColor,
          ),
        ),
        home: Scaffold(
          body: Container(
            child: Center(
              child: Text(
                'Hello World',
                style: TextStyles.headingRegular.copyWith(
                    color: AppColors.classicAdaptiveTextColor(context)),
              ),
            ),
          ),
        ));
  }
}
