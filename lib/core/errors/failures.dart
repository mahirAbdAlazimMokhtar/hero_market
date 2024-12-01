import 'package:equatable/equatable.dart';

import 'exceptions.dart';

sealed class Failures extends Equatable {
  final String message;
  final int statusCode;

  const Failures({required this.message, required this.statusCode});
  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failures {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException e)
      : this(message: e.message, statusCode: e.statusCode);
}

class CacheFailure extends Failures {
  const CacheFailure({required super.message}) : super(statusCode: 3);

  CacheFailure.fromException(CacheException e) : this(message: e.message);
}
