import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hero_market/core/extensions/context_extensions.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPFields extends StatelessWidget {
  const OTPFields({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      //this for It restricts the input to be numbers only (0-9).
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      autoFocus: true,
      length: 4,
      dialogConfig: DialogConfig(
        dialogTitle: 'Enter OTP',
        dialogContent: 'Do you want to paste OTP?',
      ),
      textStyle: AppTextStyles.headingMedium1.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.classicAdaptiveTextColor(context)),
      pinTheme: PinTheme(
        inactiveColor: const Color(0xFFEEEEEE),
        selectedColor: context.theme.primaryColor,
        activeColor: context.theme.primaryColor,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 59,
        fieldWidth: 86,
        activeFillColor: const Color(0xFFFAFBFA),
        inactiveFillColor: const Color(0xFFFAFBFA),
      ),
      onChanged: (_) {},
      onCompleted: (pin) => controller.text = pin,
      beforeTextPaste: (value) {
        return value != null &&
            value.isNotEmpty &&
            value.length == 4 &&
            int.tryParse(value) != null;
      },
    );
  }
}
