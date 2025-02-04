// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hero_market/core/common/app/providers/user_provider.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:provider/provider.dart';

import 'core/common/app/cache_helper.dart';

import 'core/common/singletons/cache.dart';
import 'core/resources/styles/colors.dart';
import 'core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  sl<CacheHelper>().getThemeMode();
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
    return ChangeNotifierProvider(
        create: (_) => sl<UserProvider>(),
        child: ValueListenableBuilder(
            valueListenable: Cache.instance.themeModeNotifier,
            builder: (_, themeMode, __) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: router,
                title: 'Hero Market App',
                themeMode: themeMode,
                theme: theme,
                darkTheme: theme.copyWith(
                  scaffoldBackgroundColor: AppColors.darkThemeBGDark,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: AppColors.darkThemeBGDark,
                    foregroundColor: AppColors.lightThemeWhiteColor,
                  ),
                ),
              );
            }));
  }
}
//
