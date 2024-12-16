// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hero_market/core/common/models/user_model.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/services/injection_container.dart';
import 'package:hero_market/core/utils/constants/network_constants.dart';
import 'package:hero_market/core/utils/error_response.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

import '../../../../core/common/app/cache_helper.dart';
import '../../../../core/utils/network_utils.dart';

abstract class AuthRemoteDataSource {
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  });  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> forgetPassword(String email);

  Future<void> verifyOtp({required String email, required String otp});

  Future<void> resetPassword(
      {required String email, required String newPassword});

  Future<bool> verifyToken();
}

////////////////////////////////////////////////////////////////////////////////
///
const REGISTER_ENDPOINT = "/register";
const LOGIN_ENDPOINT = "/login";
const FORGET_PASSWORD_ENDPOINT = "/forget-password";
const VERIFY_OTP_ENDPOINT = "/verify-otp";
const RESET_PASSWORD_ENDPOINT = "/reset-password";
const VERIFY_TOKEN_ENDPOINT = "/verify-token";

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final http.Client _httpClient;

  AuthRemoteDataSourceImplementation(this._httpClient);
  @override
  Future<void> forgetPassword(String email) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$FORGET_PASSWORD_ENDPOINT');
      final response = await _httpClient.post(
        uri,
        body: jsonEncode({'email': email}),
        headers: NetworkConstants.headers,
      );

      if (response.statusCode == 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
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
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$LOGIN_ENDPOINT');
      final response = await _httpClient.post(
        uri,
        body: jsonEncode({'email': email, 'password': password}),
        headers: NetworkConstants.headers,
      );
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
      await sl<CacheHelper>().cacheSessionToken(payload['accessToken']);
      final user = UserModel.fromMap(payload);
      await sl<CacheHelper>().cacheUserId(user.id);
      return user;
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
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$REGISTER_ENDPOINT');
      final response = await _httpClient.post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone
        }),
        headers: NetworkConstants.headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
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
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$RESET_PASSWORD_ENDPOINT');
      final response = await _httpClient.post(
        uri,
        body: jsonEncode({'email': email, 'newPassword': newPassword}),
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
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
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$VERIFY_OTP_ENDPOINT');
      final response = await http.post(
        uri,
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: NetworkConstants.headers,
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
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
  Future<bool> verifyToken() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$VERIFY_TOKEN_ENDPOINT');
      final response = await _httpClient.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        payload as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode);
      }
      return payload as bool;
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
}
