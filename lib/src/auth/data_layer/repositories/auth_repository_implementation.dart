import 'package:dartz/dartz.dart';
import 'package:hero_market/core/common/entities/user.dart';

import 'package:hero_market/core/errors/exceptions.dart';

import 'package:hero_market/core/utils/typedefs.dart';

import '../../../../core/errors/failures.dart';
import '../../domain_layer/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;



  @override
  ResultFuture<User> login(
      {required String email, required String password}) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<void> registerUser(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final result = await _remoteDataSource.registerUser(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> resetPassword(
      {required String email, required String newPassword}) async {
    try {
      final result = await _remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<void> verifyOtp(
      {required String email, required String otp}) async {
    try {
      final result = await _remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<bool> verifyToken() async {
    try {
      final result = await _remoteDataSource.verifyToken();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }
  
  @override
  ResultFuture<void> forgetPassword(String email) async {
   try {
     final result = await _remoteDataSource.forgetPassword(email);
     return Right(result);
   }on ServerException catch (e) {
     return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
   }
  }
}
