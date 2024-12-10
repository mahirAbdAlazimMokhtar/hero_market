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
  })  : _forgetPassword = forgotPassword,
        _login = login,
        _register = register,
        _resetPassword = resetPassword,
        _verifyOtp = verifyOtp,
        _verifyToken = verifyToken,
        super(AuthInitial());

  final ForgotPassword _forgetPassword;
  final Login _login;
  final Register _register;
  final ResetPassword _resetPassword;
  final VerifyOtp _verifyOtp;
  final VerifyToken _verifyToken;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _login(LoginParams(email: email, password: password));
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (user) {
      UserProvider.instance.setUser(user);
      emit(LoggedIn(user));
    });
  }
}
