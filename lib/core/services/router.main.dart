part of 'router.dart';

final router = GoRouter(
  debugLogDiagnostics: kDebugMode,
  //First screen
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const LoginView(),
    ),
  ],
);
