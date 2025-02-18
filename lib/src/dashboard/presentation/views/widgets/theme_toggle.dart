import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/app/cache_helper.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/core/services/router.dart';

import '../../../../../core/resources/styles/colors.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  late ThemeMode mode;
  void rebuild(Element element) {
    element.markNeedsBuild();
    element.visitChildren(rebuild);
  }

  @override
  void initState() {
    mode = Cache.instance.themeModeNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: Offset.zero,
                end: Offset(
                  0,
                  animation.value,
                ),
              ),
            ),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        key: UniqueKey(),
        onTap: () async {
          setState(() {
            switch (mode) {
              case ThemeMode.system:
                mode = ThemeMode.dark;
              case ThemeMode.light:
                mode = ThemeMode.system;
              case ThemeMode.dark:
                mode = ThemeMode.light;
            }
          });
          await sl<CacheHelper>().cacheThemeMode(mode);
         rootNavigatorKey.currentContext?.visitChildElements(rebuild);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  size: 30,
                  color: context.isDarkMode
                      ? AppColors.lightThemeSecondaryTextColor
                      : Colors.yellow,
                  switch (mode) {
                    ThemeMode.light => Icons.light_mode,
                    ThemeMode.dark => Icons.dark_mode,
                    ThemeMode.system => switch (defaultTargetPlatform) {
                        TargetPlatform.android ||
                        TargetPlatform.fuchsia =>
                          Icons.phone_android_rounded,
                        TargetPlatform.iOS => Icons.phone_iphone_rounded,
                        TargetPlatform.linux => Icons.laptop_chromebook_rounded,
                        TargetPlatform.macOS => Icons.laptop_mac_rounded,
                        TargetPlatform.windows => Icons.laptop_windows_rounded,
                      }
                  }),
                   Gap(10),
              Text(
                switch (mode) {
                  ThemeMode.system => 'System',
                  ThemeMode.light => 'Light',
                  ThemeMode.dark => 'Dark',
                },
                style:
                    AppTextStyles.paragraphSubTextRegular2.adaptiveColor(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
