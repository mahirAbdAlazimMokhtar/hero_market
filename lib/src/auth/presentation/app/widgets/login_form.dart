import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/common/widgets/vertical_label_field.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';

import '../../../../../core/resources/styles/colors.dart';
import '../screens/forgot_password_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          VerticalLabelField(
            label: 'Email',
            controller: emailController,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          const Gap(20),
          ValueListenableBuilder(
            valueListenable: obscurePasswordNotifier,
            builder: (_, obscurePassword, __) {
              return VerticalLabelField(
                label: 'Password',
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () => obscurePasswordNotifier.value = !obscurePassword,
                  child: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.lightThemeSecondaryTextColor,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          SizedBox(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  context.go(ForgotPasswordScreen.path);
                },
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.paragraphSubTextRegular1
                      .adaptiveColor(context),
                ),
              ),
            ),
          ),
          const Gap(40),
          RoundedButton(text: 'Sign In', onPressed: () {
            if (formKey.currentState!.validate()) {}
            
          }).loading(false),
        ],
      ),
    );
  }
}
