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
        name: params.name,
        phone: params.phone);
  }
}

class RegisterParams extends Equatable {
  const RegisterParams(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});

  final String email;
  final String password;
  final String name;
  final String phone;

  const RegisterParams.empty()
      : email = 'Test String Email',
        password = 'Test String Password',
        name = 'Test String Name',
        phone = 'Test String Phone';

  @override
  List<dynamic> get props => [email, password, name, phone];
}
