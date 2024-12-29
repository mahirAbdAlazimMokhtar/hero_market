import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/auth/presentation/app/screens/register_screen.dart';

import '../../../../../core/resources/styles/colors.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const path = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign in',
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
                'Hello!!',
                style: AppTextStyles.headingBold3.adaptiveColor(context),
              ),
              //sign in with your account details
              Text(
                'Sign in with your account details',
                style: AppTextStyles.paragraphSubTextRegular1.grey,
              ),
              const Gap(60),
              const LoginForm(),
            ],
          ),
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
              text: 'Don\'t have an account? ',
              style: AppTextStyles.paragraphSubTextRegular3.grey,
              children: [
                TextSpan(
                  text: 'Create Account',
                  style: TextStyle(
                    color: AppColors.lightThemePrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.go(RegisterScreen.path);
                    },
                )
              ]),
        ),
        const Gap(25)
      ]),
    );
  }
}
