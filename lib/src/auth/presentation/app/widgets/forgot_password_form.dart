
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';

import '../../../../../core/common/widgets/rounded_button.dart';
import '../../../../../core/common/widgets/vertical_label_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
          const Gap(40),
          RoundedButton(
            text: 'Continue',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // TODO(Forgot-Password): Implement Email Submission here
                // context.push(
                //   VerifyOTPScreen.path,
                //   extra: emailController.text.trim(),
                // );
              }
            },
          ).loading(false),
        ],
      ),
    );
  }
}
