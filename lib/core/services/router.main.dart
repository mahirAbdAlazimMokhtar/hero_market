part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  //First screen
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final cacheHelper = sl<CacheHelper>()
          ..getSessionToken()
          ..getUserId();
        if ((Cache.instance.sessionToken == null ||
                Cache.instance.userId == null) &&
            !cacheHelper.isFirstTime()) {
          return LoginScreen.path;
        }
        if (state.extra == 'home') return HomeViews.path;
        return null;
      },
      builder: (_, __) {
        final cacheHelper = sl<CacheHelper>()
          ..getSessionToken()
          ..getUserId();
        if (cacheHelper.isFirstTime()) {
          return const OnBoardingScreen();
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthCubit>()),
            BlocProvider(create: (_) => sl<AuthUserCubit>()),
          ],
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(path: LoginScreen.path, builder: (_, __) => const LoginScreen()),
    GoRoute(
        path: RegisterScreen.path, builder: (_, __) => const RegisterScreen()),
    GoRoute(
        path: ForgotPasswordScreen.path,
        builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(
      path: ResetPasswordScreen.path,
      builder: (_, state) {
        final email = state.extra as String?;
        if (email == null) {
          return ErrorScreen(message: 'Email is required');
        }
        return ResetPasswordScreen(email: email);
      },
    ),
    GoRoute(
      path: VerifyOtpScreen.path,
      builder: (_, state) {
        final email = state.extra as String?;
        if (email == null) {
          return ErrorScreen(message: 'Email is required');
        }
        return VerifyOtpScreen(email: email);
      },
    ),
    ShellRoute(
      routes: [
        GoRoute(path: HomeViews.path, builder: (_, __) => const HomeViews()),
      ],
      builder: (context, state, child) {
        return DashboardScreen(state: state, child: child);
      },
    )
  ],
);
