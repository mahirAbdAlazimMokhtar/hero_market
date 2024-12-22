

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.suffixIcon,
      this.hintText,
      this.validator,
      this.prefixIcon,
      this.prefix,
      this.obscureText = false,
      required this.controller,
      this.keyboardType,
      this.defaultValidation = true,
      this.inputFormatters,
      this.enabled = true,
      this.readOnly = true,
      this.contentPadding,
      this.focusNode,
      this.onTap,
      this.expandable = false});

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
  final bool expandable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: defaultValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Required Field';
              }
              return validator?.call(value);
            }
          : validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      onTap: onTap,
      maxLines: expandable ? 5 : 1,
      minLines: expandable ? 1 : null,
      style: AppTextStyles.paragraphSubTextRegular3.adaptiveColor(context),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.primaryColor),
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hintText,
        suffixIconColor: AppColors.lightThemeSecondaryTextColor,
        suffixIcon: suffixIcon,
        hintStyle: AppTextStyles.paragraphSubTextRegular3.grey,
        prefixIcon: prefixIcon,
        prefix: prefix,
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        filled: true,
        fillColor: CoreUtils.adaptiveColor(context,
            lightModeColor: AppColors.lightThemeStockColor,
            darkModeColor: AppColors.darkThemeDarkSharpColor),
      ),
    );
  }
}
