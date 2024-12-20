import 'package:hero_market/core/utils/typedefs.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ForgotPassword extends UsecasesWithParams<void, String> {
  final AuthRepository _repository;

  ForgotPassword(this._repository);

  @override
  ResultFuture<void> call(String params) {
    return _repository.forgetPassword(params);
  }
}
