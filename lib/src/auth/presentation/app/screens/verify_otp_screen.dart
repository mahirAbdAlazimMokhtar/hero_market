import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/auth/presentation/app/widgets/otp_timer.dart';

import '../../../../../core/common/widgets/app_bar_bottom.dart';
import '../../../../../core/resources/styles/text.dart';
import '../widgets/otp_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  static const String path = '/verify-otp';
  const VerifyOtpScreen({super.key, required this.email});
  final String email;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify OTP',
          style: AppTextStyles.headingSemiBold,
        ),
        bottom: const AppBarBottom(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        children: [
          Text(
            'Verification Code',
            style: AppTextStyles.headingBold3.adaptiveColor(context),
          ),
          Text(
            'Code has been sent to ${widget.email.obscureEmail}',
            style: AppTextStyles.paragraphSubTextRegular1.grey,
          ),
          const Gap(40),
          OTPFields(
            controller: otpController,
          ),
          const Gap(30),
          OTPTimer(email: widget.email),
          const Gap(40),
          RoundedButton(
            text: 'Verify',
            onPressed: (){
              if(otpController.text.length < 4){
                CoreUtils.showSnackBar(context, message: 'Invalid OTP');
              }else{
                
              }
            },
          ).loading(false)
        ],
      ),
    );
  }
}
