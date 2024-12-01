import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../repositories/auth_repository.dart';

class ResetPassword extends UsecasesWithParams<void, ResetPasswordParams> {
  final AuthRepository _repository;

  ResetPassword(this._repository);

  @override
  ResultFuture<void> call(ResetPasswordParams params) {
    return _repository.resetPassword(
      email: params.email,
      newPassword: params.newPassword,
    );
  }
}

class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({required this.email, required this.newPassword});

  const ResetPasswordParams.empty()
      : email = 'Test String Email ',
        newPassword = 'Test String Password';

  final String email;
  final String newPassword;
  @override
  List<dynamic> get props => [email, newPassword];
}
