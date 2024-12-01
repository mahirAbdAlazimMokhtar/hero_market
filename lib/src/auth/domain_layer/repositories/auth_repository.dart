import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();
  ResultFuture<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  ResultFuture<User> login({
    required String email,
    required String password,
  });

  ResultFuture<void> forgetPassword({String email});


  ResultFuture<void> verifyOtp({required String email, required String otp});

  ResultFuture<void> resetPassword(
      {required String email, required String newPassword});

  ResultFuture<bool> verifyToken();
}
