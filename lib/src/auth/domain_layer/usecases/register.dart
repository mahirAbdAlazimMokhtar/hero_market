import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../repositories/auth_repository.dart';

class Register extends UsecasesWithParams<void, RegisterParams> {
  final AuthRepository _repository;

  Register(this._repository);

  @override
  ResultFuture<void> call(RegisterParams params) {
    return _repository.registerUser(
        email: params.email,
        password: params.password,
        name: params.fullName,
        phone: params.userPhoneNumber);
  }
}

class RegisterParams extends Equatable {
  const RegisterParams(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.userPhoneNumber});

  final String email;
  final String password;
  final String fullName;
  final String userPhoneNumber;

  const RegisterParams.empty()
      : email = 'Test String Email',
        password = 'Test String Password',
        fullName = 'Test String Name',
        userPhoneNumber = 'Test String Phone';

  @override
  List<dynamic> get props => [email, password, fullName, userPhoneNumber];
}
