// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_market/core/common/app/providers/user_provider.dart';

import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/forget_password.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/login.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/register.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/reset_password.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/verify_otp.dart';
import 'package:hero_market/src/auth/domain_layer/usecases/verify_token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required ForgotPassword forgotPassword,
    required Login login,
    required Register register,
    required ResetPassword resetPassword,
    required VerifyOtp verifyOtp,
    required VerifyToken verifyToken,
    required UserProvider userProvider,
  })  : _forgetPassword = forgotPassword,
        _login = login,
        _register = register,
        _resetPassword = resetPassword,
        _verifyOtp = verifyOtp,
        _verifyToken = verifyToken,
        _userProvider = userProvider,
        super(AuthInitial());

  final ForgotPassword _forgetPassword;
  final Login _login;
  final Register _register;
  final ResetPassword _resetPassword;
  final VerifyOtp _verifyOtp;
  final VerifyToken _verifyToken;
  final UserProvider _userProvider;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _login(LoginParams(email: email, password: password));
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (user) {
      _userProvider.setUser(user);
      emit(LoggedIn(user));
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    final result = await _register(RegisterParams(
      email: email,
      password: password,
      fullName: fullName,
      userPhoneNumber: phoneNumber,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const Registered()),
    );
  }

  Future<void> forgetPassword(String email) async {
    emit(AuthLoading());
    final result = await _forgetPassword(email);
    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const OTPSent()));
  }

  Future<void> resetPassword(
      {required String email, required String newPassword}) async {
    emit(AuthLoading());
    final result = await _resetPassword(
        ResetPasswordParams(email: email, newPassword: newPassword));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const PasswordReset()),
    );
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(AuthLoading());
    final result = await _verifyOtp(VerifyOtpParams(email: email, otp: otp));
    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const OTPVerified()));
  }

  Future<void> verifyToken() async {
    emit(AuthLoading());
    final result = await _verifyToken();
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (isValid) {
      emit(TokenVerified(isValid));
      if (!isValid) {
        _userProvider.setUser(null);
      }
    });
  }
}
