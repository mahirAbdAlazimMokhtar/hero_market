import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import 'package:hero_market/src/auth/presentation/app/screens/verify_otp_screen.dart';
import '../../../../../core/common/widgets/rounded_button.dart';
import '../../../../../core/common/widgets/vertical_label_field.dart';
import '../../../../../core/utils/core_utils.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state case AuthError(:final message)){
          CoreUtils.showSnackBar(context,message: message);
        }else if(state is OTPSent){
          context.go(VerifyOtpScreen.path,extra: {'email': emailController.text});
        }
      },
      builder: (context, state) {
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
                    context
                        .read<AuthCubit>()
                        .forgotPassword(email: emailController.text);
                  }
                },
              ).loading(state is AuthLoading),
            ],
          ),
        );
      },
    );
  }
}
