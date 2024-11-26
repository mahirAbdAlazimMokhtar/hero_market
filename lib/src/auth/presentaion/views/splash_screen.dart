import 'package:flutter/material.dart';
import 'package:hero_market/core/common/widgets/ecomly_logo.dart';
import 'package:hero_market/core/resources/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightThemePrimaryColor,
      body: Center(child: EcomlyLogo()),
    );
  }
}