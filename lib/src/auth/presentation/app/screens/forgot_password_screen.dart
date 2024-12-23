import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';

import '../../../../../core/common/widgets/app_bar_bottom.dart';
import '../../../../../core/resources/styles/text.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const path = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: AppTextStyles.headingSemiBold,
        ),
        bottom: const AppBarBottom(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        children: [
          Text(
            'Confirm Email',
            style: AppTextStyles.headingBold3.adaptiveColor(context),
          ),
          Text(
            'Enter the email address associated with your account.',
            style: AppTextStyles.paragraphSubTextRegular1.grey,
          ),
          const Gap(40),
          const ForgotPasswordForm(),
        ],
      ),
    );
  }
}