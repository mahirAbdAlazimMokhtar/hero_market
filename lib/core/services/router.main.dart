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

        if ((sessionToken == null || userId == null) &&
            !cacheHelper.isFirstTime()) {
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
        GoRoute(
            path: HomeViews.path,
            routes: [
              GoRoute(
                path: AllNewArrivalsView.path,
                builder: (_, __) => ChangeNotifierProvider(
                  create: (context) => SearchControllers(),
                  child: BlocProvider(
                    create: (_) => sl<ProductCubit>(),
                    child: const AllNewArrivalsView(),
                  ),
                ),
              ),
              GoRoute(
                path: AllPopularView.path,
                builder: (_, __) => ChangeNotifierProvider(
                  create: (context) => SearchControllers(),
                  child: BlocProvider(
                    create: (_) => sl<ProductCubit>(),
                    child: const AllPopularView(),
                  ),
                ),
              ),
            ],
            builder: (_, __) => BlocProvider(
                  create: (_) => sl<ProductCubit>(),
                  child: HomeViews(),
                )),
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
      path: SearchView.path,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<
                ProductCubit>(), // استخدام نفس الكيوبت بدلاً من إنشائه من جديد
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => SearchControllers(),
          child: const SearchView(),
        ),
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/products/:productId',
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ProductCubit>()),
            BlocProvider(create: (_) => sl<CartCubit>()),
          ],
          child: ProductDetailsView(
            state.pathParameters['productId'] as String,
          ),
        );
      },
    ),
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: SearchView.path,
        builder: (_, state) => PaymentProfileView(
              sessionUrl: state.extra as String,
            )),
  ],
);
