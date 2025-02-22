import 'package:flutter/material.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

class HeroLogo extends StatelessWidget {
  const HeroLogo({super.key, this.style});
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: 'Hero',
          style: style ?? AppTextStyles.appLogo.white,
          children: const [
            TextSpan(
              text: 'Market',
              style: TextStyle(color: AppColors.lightThemeSecondaryColor),
            ),
          ]),
    );
  }
}
