import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/input_field.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

import '../../resources/styles/text.dart';

class VerticalLabelField extends StatelessWidget {
  const VerticalLabelField(
      {super.key,
      required this.label,
      required this.controller,
      this.suffixIcon,
      this.hintText,
      this.validator,
      this.prefixIcon,
      this.prefix,
      this.obscureText = false,
      this.keyboardType,
      this.defaultValidation = true,
      this.inputFormatters,
      this.enabled = true,
      this.readOnly = false,
      this.contentPadding,
      this.focusNode,
      this.onTap,
      this.mainFieldFlex = 1,
      this.prefixFlex = 1});

  final String label;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final int mainFieldFlex;
  final int prefixFlex;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.headingMedium4.adaptiveColor(context),
        ),
        const Gap(10),
        Row(children: [
          if (prefix != null) ...{
            Expanded(
              flex: prefixFlex,
              child: prefix!,
            ),
            const Gap(20)
          },
          Expanded(
            child: InputField(
              controller: controller,
              suffixIcon: suffixIcon,
              hintText: hintText,
              validator: validator,
              prefixIcon: prefixIcon,
              prefix: prefix,
              obscureText: obscureText,
              keyboardType: keyboardType,
              defaultValidation: defaultValidation,
              inputFormatters: inputFormatters,
              enabled: enabled,
              readOnly: readOnly,
              contentPadding: contentPadding,
              focusNode: focusNode,
              onTap: onTap,
            ),
          )
        ])
      ],
    );
  }
}
