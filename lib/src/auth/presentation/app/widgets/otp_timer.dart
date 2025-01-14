import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';

import '../../../../../core/resources/styles/colors.dart';

class OTPTimer extends StatefulWidget {
  const OTPTimer({required this.email, super.key});

  final String email;

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  int _mainDuration = 60;

  int _duration = 60;

  int increment = 10;

  Timer? _timer;

  bool canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _duration--;
        });
        if (_duration == 0) {
          // we use 10 seconds increment after each resend
          if (_mainDuration > 60) increment *= 2;

          _mainDuration += increment;
          _duration = _mainDuration;

          timer.cancel();

          setState(() {
            canResend = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _duration ~/ 60;
    final seconds = _duration.remainder(60);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context,state){
        if(state is OTPSent){
          _startTimer();
          setState(() {
            canResend = false;
          });
        }
      },
      builder: (context, state) {
        return Center(
            child: switch (canResend) {
          true => switch (state) {
              AuthLoading _ => const SizedBox.shrink(),
              _ => TextButton(
                  onPressed: () async {
                    context
                        .read<AuthCubit>()
                        .forgotPassword(email: widget.email);
                  },
                  child: Text(
                    'Resend Code',
                    style: AppTextStyles.headingMedium4.primary,
                  ),
                ),
            },
          _ => RichText(
              text: TextSpan(
                text: 'Resend code in ',
                style: AppTextStyles.headingMedium4.grey,
                children: [
                  TextSpan(
                    text: '$minutes:${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: AppColors.lightThemePrimaryColor,
                    ),
                  ),
                  const TextSpan(text: ' seconds'),
                ],
              ),
            ),
        });
      },
    );
  }
}
