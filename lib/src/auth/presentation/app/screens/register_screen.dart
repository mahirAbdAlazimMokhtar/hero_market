import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/auth/presentation/app/screens/login_screen.dart';
import 'package:hero_market/src/auth/presentation/app/widgets/register_form.dart';

import '../../../../../core/resources/styles/colors.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const path = '/register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
          style: AppTextStyles.headingSemiBold,
        ),
        bottom: const AppBarBottom(),
      ),
      body: Column(children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            shrinkWrap: true,
            children: [
              Text(
                'Create an account',
                style: AppTextStyles.headingBold3.adaptiveColor(context),
              ),
              //sign in with your account details
              Text(
                'Create a new account with your account details',
                style: AppTextStyles.paragraphSubTextRegular1.grey,
              ),
              const Gap(60),
              const RegistrationForm(),
            ],
          ),
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
              text: 'Already have an account? ',
              style: AppTextStyles.paragraphSubTextRegular3.grey,
              children: [
                TextSpan(
                  text: 'Sign in',
                  style: TextStyle(
                    color: AppColors.lightThemePrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.go(LoginScreen.path);
                    },
                )
              ]),
        ),
        const Gap(25)
      ]),
    );
  }
}
