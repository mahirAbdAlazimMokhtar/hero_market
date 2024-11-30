import 'package:flutter/material.dart';

import 'package:hero_market/core/extensions/text_style_extensions.dart';

import 'package:hero_market/core/resources/media/media.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';

class OnBoardingInfoSection extends StatelessWidget {
  const OnBoardingInfoSection.first({super.key}) : first = true;
  const OnBoardingInfoSection.second({super.key}) : first = false;

  final bool first;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(first ? Media.onBoardingFemale : Media.onBoardingMale),
        ),
       
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (first) {
              true => Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: '${DateTime.now().year} \n',
                      style: AppTextStyles.headingBold.orange,
                      children: [
                        TextSpan(
                            text: 'Winter Sale is live now.',
                            style: TextStyle(
                                color: AppColors.classicAdaptiveTextColor(
                                    context)))
                      ]),
                ),
              _ => Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: 'Flash Sale \n',
                      style: AppTextStyles.headingBold.adaptiveColor(context),
                      children: [
                        const TextSpan(
                            text: "Men's ",
                            style: TextStyle(
                                color: AppColors.lightThemeSecondaryTextColor)),
                        TextSpan(
                            text: 'Shirts & Watches',
                            style: TextStyle(
                                color: AppColors.classicAdaptiveTextColor(
                                    context)))
                      ]))
            }
          ],
        )
      ],
    );
  }
}
