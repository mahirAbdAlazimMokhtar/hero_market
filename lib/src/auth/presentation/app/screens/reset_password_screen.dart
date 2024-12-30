import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';

import '../../../../../core/common/widgets/app_bar_bottom.dart';
import '../widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({required this.email, super.key});

  static const path = '/reset-password';

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: AppTextStyles.headingSemiBold,
        ),
        bottom: const AppBarBottom(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        children: [
          Text(
            'Change Password',
            style: AppTextStyles.headingBold3.adaptiveColor(context),
          ),
          Text(
            'Pick a new secure password',
            style: AppTextStyles.paragraphSubTextRegular1.grey,
          ),
          const Gap(40),
          ResetPasswordForm(email: email),
        ],
      ),
    );
  }
}