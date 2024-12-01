import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/auth/domain_layer/repositories/auth_repository.dart';

class VerifyOtp extends UsecasesWithParams<void, VerifyOtpParams> {
  final AuthRepository _repository;

  VerifyOtp(this._repository);

  @override
  ResultFuture<void> call(VerifyOtpParams params) {
    return _repository.verifyOtp(email: params.email, otp: params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  final String otp;
  final String email;

  const VerifyOtpParams({required this.otp, required this.email});

  const VerifyOtpParams.empty()
      : email = 'Test String Email',
        otp = 'Test String Otp';

  @override
  List<dynamic> get props => [otp, email];
}
