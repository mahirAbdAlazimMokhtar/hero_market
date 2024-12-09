import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import '../repositories/auth_repository.dart';
class VerifyToken extends UsecasesWithoutParams<bool> {
  final AuthRepository _repository;

  VerifyToken(this._repository);

  @override
  ResultFuture<bool> call() => _repository.verifyToken();
}
