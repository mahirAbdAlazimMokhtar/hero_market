import 'package:dartz/dartz.dart';
import 'package:hero_market/core/common/entities/user.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/errors/failures.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/user/data/datasources/user_remote_data_source.dart';
import 'package:hero_market/src/user/domain/repository/user_repo.dart';

class UserRepositoryImplementation implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImplementation(this._userRemoteDataSource);

  @override
  ResultFuture<User> getUser(String userId) async {
    try {
      final result = await _userRemoteDataSource.getUser(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<String> getUserPaymentProfile(String userId) async {
    try {
      final result = await _userRemoteDataSource.getUserPaymentProfile(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final result = await _userRemoteDataSource.updateUser(
        updateData: updateData,
        userId: userId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }
}
