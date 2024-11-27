import 'package:flutter/material.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/utils/core_utils.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ColoredBox(
        color: CoreUtils.adaptiveColor(
          context,
          lightModeColor: Colors.white,
          darkModeColor: AppColors.darkThemeDarkSharpColor,
        ),
        child: const SizedBox(
          height: 1,
          width: double.maxFinite,
        ),
      ),
    );
  } 

  @override
  Size get preferredSize => Size.zero;
}
