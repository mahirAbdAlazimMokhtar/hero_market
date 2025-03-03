part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _userInit();
  await _productInit();
  await _cartInit();
  await _wishlistInit();
}

Future<void> _productInit() async {
  sl
    ..registerFactory(
      () => ProductCubit(
        getCategories: sl(),
        getCategory: sl(),
        getPopular: sl(),
        getProductReviews: sl(),
        getProduct: sl(),
        getProductsByCategory: sl(),
        getProducts: sl(),
        leaveReview: sl(),
        searchAllProducts: sl(),
        searchByCategory: sl(),
        searchByCategoryAndGenderAgeCategory: sl(),
        getNewArrivals: sl(),
      ),
    )
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetCategory(sl()))
    ..registerLazySingleton(() => GetPopular(sl()))
    ..registerLazySingleton(() => GetProductReviews(sl()))
    ..registerLazySingleton(() => GetProduct(sl()))
    ..registerLazySingleton(() => GetProductsByCategory(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => LeaveReview(sl()))
    ..registerLazySingleton(() => SearchAllProducts(sl()))
    ..registerLazySingleton(() => SearchByCategory(sl()))
    ..registerLazySingleton(() => SearchByCategoryAndGenderAgeCategory(sl()))
    ..registerLazySingleton(() => GetNewArrivals(sl()))
    ..registerLazySingleton<ProductRepo>(() => ProductRepoImpl(sl()))
    ..registerLazySingleton<ProductModelsRemoteDataSrc>(
        () => ProductRemoteDataSrcImpl(sl()));
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
    ..registerLazySingleton(UserProvider.new)
    ..registerLazySingleton(http.Client.new);
}
Future<void> _cartInit() async {
  sl
    ..registerFactory(
      () => CartCubit(
        addToCart: sl(),
        changeCartProductQuantity: sl(),
        getCart: sl(),
        getCartCount: sl(),
        getCartProduct: sl(),
        removeFromCart: sl(),
        initiateCheckout: sl(),
      ),
    )
    ..registerLazySingleton(() => AddToCart(sl()))
    ..registerLazySingleton(() => ChangeCartProductQuantity(sl()))
    ..registerLazySingleton(() => GetCart(sl()))
    ..registerLazySingleton(() => GetCartCount(sl()))
    ..registerLazySingleton(() => GetCartProduct(sl()))
    ..registerLazySingleton(() => RemoveFromCart(sl()))
    ..registerLazySingleton(() => InitiateCheckout(sl()))
    ..registerLazySingleton<CartRepo>(() => CartRepoImpl(sl()))
    ..registerLazySingleton<CartRemoteDataSrc>(
      () => CartRemoteDataSrcImpl(sl()),
    );
}
Future<void> _wishlistInit() async {
  sl
    ..registerFactory(
      () => WishlistCubit(
        addToWishlist: sl(),
        getWishlist: sl(),
        removeFromWishlist: sl(),
      ),
    )
    ..registerLazySingleton(() => AddToWishlist(sl()))
    ..registerLazySingleton(() => GetWishlist(sl()))
    ..registerLazySingleton(() => RemoveFromWishlist(sl()))
    ..registerLazySingleton<WishlistRepo>(() => WishlistRepoImpl(sl()))
    ..registerLazySingleton<WishlistRemoteDataSrc>(
      () => WishlistRemoteDataSrcImpl(sl()),
    );
}
Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(
      prefs); // تسجيل SharedPreferences أولاً
  sl.registerLazySingleton<CacheHelper>(
      () => CacheHelper(sl())..getThemeMode());
}
