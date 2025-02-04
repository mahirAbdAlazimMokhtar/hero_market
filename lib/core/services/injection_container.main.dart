part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _userInit();
}

Future<void> _userInit() async {
  sl
    ..registerFactory(() => AuthUserCubit(
        getUser: sl(),
        getUserPaymentProfile: sl(),
        updateUser: sl(),
        userProvider: sl()))
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton(() => GetUserPaymentProfile(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<UserRepo>(() => UserRepositoryImplementation(sl()))
    ..registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImplementation(sl()));
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthCubit(
        forgotPassword: sl(),
        login: sl(),
        register: sl(),
        resetPassword: sl(),
        verifyOtp: sl(),
        verifyToken: sl(),
        userProvider: sl(),
      ),
    )
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => Register(sl()))
    ..registerLazySingleton(() => ResetPassword(sl()))
    ..registerLazySingleton(() => VerifyOtp(sl()))
    ..registerLazySingleton(() => VerifyToken(sl()))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImplementation(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImplementation(sl()))
    ..registerLazySingleton(() => UserProvider.instance)
    ..registerLazySingleton(http.Client.new);
}


Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(prefs); // تسجيل SharedPreferences أولاً
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sl())..getThemeMode());
}


