
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/user/domain/repository/user_repo.dart';

import '../../../../core/common/entities/user.dart';

class GetUser extends UsecasesWithParams<User, String> {
  final UserRepo _userRepo;

  GetUser(this._userRepo);

  @override
  ResultFuture<User> call(String params)  {
    return _userRepo.getUser(params);
  }
}
