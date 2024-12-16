import 'package:equatable/equatable.dart';
import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../repository/user_repo.dart';

class UpdateUser extends UsecasesWithParams<User, UpdateUserParams> {
  final UserRepo _userRepo;

  UpdateUser(this._userRepo);

  @override
  ResultFuture<User> call(UpdateUserParams params)  {
    return  _userRepo.updateUser(
        userId: params.userId, updateData: params.dataMap);
  }
}

class UpdateUserParams extends Equatable {
  final String userId;
  final DataMap dataMap;

  const UpdateUserParams({required this.userId, required this.dataMap});
  @override
  List<Object?> get props => [userId, dataMap];
}
