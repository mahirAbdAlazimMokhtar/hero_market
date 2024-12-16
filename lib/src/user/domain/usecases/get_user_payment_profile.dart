import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/user/domain/repository/user_repo.dart';

class GetUserPaymentProfile  extends UsecasesWithParams<String,String>{
  final UserRepo _userRepo;
  GetUserPaymentProfile(this._userRepo);

  @override
  ResultFuture<String> call(String params) {
   return _userRepo.getUserPaymentProfile(params);
  }
  
}