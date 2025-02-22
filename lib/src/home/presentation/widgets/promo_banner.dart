import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';

import '../../../../core/common/widgets/rounded_button.dart';
import '../../../../core/resources/styles/text.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightThemePrimaryColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Up to',
                    style: AppTextStyles.paragraphSubTextRegular1.white),
                Text(
                  '50% OFF',
                  style: AppTextStyles.headingBold3.white,
                ),
                Text(
                  'WITH CODE',
                  style: TextStyle(
                      fontSize: 25,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..color = AppColors.lightThemeWhiteColor
                        ..strokeWidth = .6),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: RoundedButton(
                text: 'Get it now',
                color: AppColors.lightThemeWhiteColor,
                height: 55,
                textStyle:
                    AppTextStyles.headingBold3.primary.copyWith(fontSize: 14),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
