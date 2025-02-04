// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hero_market/core/common/models/user_model.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/constants/network_constants.dart';
import 'package:hero_market/core/utils/error_response.dart';
import 'package:hero_market/core/utils/network_utils.dart';

import '../../../../core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  });

  Future<String> getUserPaymentProfile(String userId);
}

//---End Points For User------///
const USERS_ENDPOINT = '/users';


class UserRemoteDataSourceImplementation implements UserRemoteDataSource {
  final http.Client _client;

  UserRemoteDataSourceImplementation(this._client);

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId');
      final response = await _client.get(uri,
          headers: Cache.instance.sessionToken!.toAuthHeaders);

      final payload = jsonDecode(response.body) as DataMap;

      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
          message: "Mahir :--- Error Occurred : It's not you, it's us",
          statusCode: 500);
    }
  }

  @override
  Future<String> getUserPaymentProfile(String userId) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId/paymentProfile');
      final response = await _client.get(uri,
          headers: Cache.instance.sessionToken!.toAuthHeaders);

      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
      return payload['url'] as String;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const ServerException(
          message: "Mahir :--- Error Occurred : It's not you, it's us",
          statusCode: 500);
    }
  }

  @override
Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId',
      );

      final response = await _client.put(
        uri,
        body: jsonEncode(updateData),
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: "Error Occurred: It's not your fault, it's ours",
        statusCode: 500,
      );
    }
  }
}
