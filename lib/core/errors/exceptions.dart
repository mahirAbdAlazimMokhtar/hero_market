import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [statusCode, message];
}

class CacheException extends Equatable implements Exception {
  const CacheException({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
