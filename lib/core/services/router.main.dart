part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
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
    
    final sessionToken = Cache.instance.sessionToken;
    final userId = Cache.instance.userId;
    
    debugPrint("Session Token: $sessionToken, UserId: $userId");
    
    if ((sessionToken == null || userId == null) && !cacheHelper.isFirstTime()) {
      return LoginScreen.path;
    }

    if (state.extra == 'home') {
      return HomeViews.path;
    }

    return null;
  },
  builder: (_, __) {
    final cacheHelper = sl<CacheHelper>()
      ..getSessionToken()
      ..getUserId();

    debugPrint("Is First Time: ${cacheHelper.isFirstTime()}");
    
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
    GoRoute(
      path: LoginScreen.path,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: ForgotPasswordScreen.path,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: VerifyOtpScreen.path,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: VerifyOtpScreen(
          email: (state.extra as Map<String, String>)['email']!,
        ),
      ),
    ),
    GoRoute(
      path: ResetPasswordScreen.path,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: ResetPasswordScreen(email: state.extra as String),
      ),
    ),
    GoRoute(
      path: RegisterScreen.path,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const RegisterScreen(),
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardScreen(state: state, child: child);
      },
      routes: [
        GoRoute(path: HomeViews.path, builder: (_, __) => const HomeViews()),
        GoRoute(
            path: ExploreView.path, builder: (_, __) => const ExploreView()),
        GoRoute(
            path: WishlistView.path, builder: (_, __) => const WishlistView()),
      ],
    ),
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: ProfileView.path,
        builder: (_, __) => const ProfileView()),
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: CartView.path,
        builder: (_, __) => const CartView()),
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PaymentProfileView.path,
        builder: (_, state) => PaymentProfileView(
              sessionUrl: state.extra as String,
            )),
  ],
);
