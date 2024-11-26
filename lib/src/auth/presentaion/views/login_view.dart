import 'package:flutter/material.dart';
import 'package:hero_market/core/common/widgets/app_bar_bottom.dart';
import 'package:hero_market/core/resources/styles/text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
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
      body:  Container(),
    );
  }
}
