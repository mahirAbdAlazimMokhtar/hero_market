import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';

import '../../../../../core/common/widgets/rounded_button.dart';
import '../../../../../core/common/widgets/vertical_label_field.dart';
import '../../../../../core/utils/core_utils.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({required this.email, super.key});

  final String email;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);
  final obscureConfirmPasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscurePasswordNotifier.dispose();
    obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is PasswordReset) {
          CoreUtils.showSnackBar(context, message: 'Password reset successful! ✅');
          context.go('/');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: obscurePasswordNotifier,
                builder: (_, obscurePassword, __) {
                  return VerticalLabelField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscurePasswordNotifier.value =
                            !obscurePasswordNotifier.value;
                      },
                      child: Icon(
                        switch (obscurePassword) {
                          true => Icons.visibility_off_outlined,
                          _ => Icons.visibility_outlined,
                        },
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscureConfirmPasswordNotifier,
                builder: (_, obscureConfirmPassword, __) {
                  return VerticalLabelField(
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscureConfirmPasswordNotifier.value =
                            !obscureConfirmPasswordNotifier.value;
                      },
                      child: Icon(
                        switch (obscureConfirmPassword) {
                          true => Icons.visibility_off_outlined,
                          _ => Icons.visibility_outlined,
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value! != passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  );
                },
              ),
              const Gap(40),
              RoundedButton(
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().resetPassword(
                          email: widget.email,
                          newPassword: passwordController.text.trim());
                    }
                  }).loading(state is AuthLoading),
            ],
          ),
        );
      },
    );
  }
}
