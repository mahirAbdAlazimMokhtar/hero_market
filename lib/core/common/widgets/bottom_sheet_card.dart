import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';

import '../../resources/styles/colors.dart';

class BottomSheetCard extends StatelessWidget {
  const BottomSheetCard(
      {super.key,
      required this.title,
      required this.positiveButtonText,
      required this.negativeButtonText,
      this.positiveButtonColor,
      this.negativeButtonColor});
  final String title;
  final String positiveButtonText;
  final String negativeButtonText;
  final Color? positiveButtonColor;
  final Color? negativeButtonColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: CoreUtils.adaptiveColor(context,
            lightModeColor: AppColors.lightThemeWhiteColor,
            darkModeColor: AppColors.darkThemeDarkNavBarColor),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headingMedium1.adaptiveColor(context),
          ),
        ),
        const Gap(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: RoundedButton(
                  text: positiveButtonText,
                  color: positiveButtonColor,
                  height: 55,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
              const Spacer(),
              Expanded(
                  flex: 3,
                  child: RoundedButton(
                    text: negativeButtonText,
                    color: negativeButtonColor,
                    height: 55,
                    onPressed: () => Navigator.of(context).pop(false),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
