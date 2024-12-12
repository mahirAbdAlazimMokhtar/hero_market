import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/app/cache_helper.dart';
import 'package:hero_market/core/common/widgets/ecomly_logo.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';

import '../../../../core/services/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().verifyToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) async {
        if (state is TokenVerified) {
          if (state.isValid) {
            // TODO(GET-USER):Create a user feature and featch user
          } else {
            final router = GoRouter.of(context);
            await sl<CacheHelper>().resetSession();
            router.go('/');
          }
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.lightThemePrimaryColor,
        body: Center(child: EcomlyLogo()),
      ),
    );
  }
}
