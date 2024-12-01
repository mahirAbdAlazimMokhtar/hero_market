import 'package:equatable/equatable.dart';
import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../repositories/auth_repository.dart';

class Login extends UsecasesWithParams<User, LoginParams> {
  final AuthRepository _repository;

  Login(this._repository);



  @override
  ResultFuture<User> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
  const LoginParams.empty()
      : this(email: 'Test String Email', password: 'Test String Password');
  @override
  List<Object?> get props => [email, password];
}
