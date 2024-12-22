import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/app/cache_helper.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/common/widgets/ecomly_logo.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';
import 'package:hero_market/src/user/app/adapter/cubit/auth_user_cubit.dart';

import '../../../../../core/services/injection_container.dart';

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
Future<void> redirectToIndex()async{
   final router = GoRouter.of(context);
              await sl<CacheHelper>().resetSession();
              router.go('/');
}
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthUserCubit, AuthUserState>(
      listener: (context, state) async {
        if (state is AuthUserError) {
          sl<CacheHelper>().resetSession();
          await redirectToIndex();
        } else {
          context.go('/', extra: 'home');
        }
      },
      child: BlocListener(
        listener: (context, state) async {
          if (state is TokenVerified) {
            if (state.isValid) {
              context.read<AuthUserCubit>().getUserById(Cache.instance.userId!);
            } else {
             await redirectToIndex();
            }
          } else if (state is AuthError) {
            await redirectToIndex();
          }
        },
        child: const Scaffold(
          backgroundColor: AppColors.lightThemePrimaryColor,
          body: Center(child: EcomlyLogo()),
        ),
      ),
    );
  }
}
