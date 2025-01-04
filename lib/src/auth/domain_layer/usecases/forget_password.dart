import 'package:hero_market/core/utils/typedefs.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ForgotPassword extends UsecasesWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgetPassword(params);
}
