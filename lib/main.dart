// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hero_market/core/services/injection_container.dart';

import 'core/resources/styles/colors.dart';
import 'core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
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
    );
  }
}
//