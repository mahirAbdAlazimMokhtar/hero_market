import 'package:flutter/material.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

import '../../resources/styles/text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.padding,
      this.style,
      this.color,
      this.height});
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height ?? 66,
        width: double.maxFinite,
        child: FilledButton(
          onPressed: () {
            // hide keyboard
            FocusManager.instance.primaryFocus?.unfocus();
            onPressed?.call();
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: color,
            padding: padding,
          ),
          child: Text(
            text,
            style: style ?? AppTextStyles.buttonTextHeadingSemiBold.white,
          ),
        ),
      ),
    );
  }
}
