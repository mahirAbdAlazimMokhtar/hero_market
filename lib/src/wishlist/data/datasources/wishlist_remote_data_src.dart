import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/constants/network_constants.dart';
import 'package:hero_market/core/utils/error_response.dart';
import 'package:hero_market/core/utils/network_utils.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/wishlist/data/models/wishlist_product_model.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSrc {
  Future<List<WishlistProductModel>> getWishlist(String userId);

  Future<void> addToWishlist({
    required String userId,
    required String productId,
  });

  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  });
}

class WishlistRemoteDataSrcImpl implements WishlistRemoteDataSrc {
  const WishlistRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<WishlistProductModel>> getWishlist(String userId) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userWishlistEndpoint(userId)}',
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        payload as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        debugPrint(response.body);
        debugPrintStack();
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      payload as List<dynamic>;
      return payload
          .cast<DataMap>()
          .map(
            (wishlistProduct) => WishlistProductModel.fromMap(wishlistProduct),
          )
          .toList();
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

@override
Future<void> addToWishlist({
  required String userId,
  required String productId,
}) async {
  try {
    // التحقق من أن userId ليس ":id"
    if (userId == ":id" || userId.isEmpty) {
      debugPrint('ERROR: Invalid userId: "$userId"');
      // استخدام معرف المستخدم من الكاش إذا كان متاحًا
      final cachedUserId = Cache.instance.userId;
      if (cachedUserId == null || cachedUserId.isEmpty) {
        throw const ServerException(
          message: "User ID not available. Please login again.",
          statusCode: 400,
        );
      }
      userId = cachedUserId;
      debugPrint('Using cached userId: "$userId"');
    }
    
    // التحقق من أن endpoint لا يحتوي على ":id"
    final endpoint = '${NetworkConstants.apiUrl}/users/$userId/wishlist';
    debugPrint('Constructed endpoint: $endpoint');
    
    final uri = Uri.http(
      NetworkConstants.authority,
      endpoint,
    );
    
    debugPrint('Adding to wishlist: $uri');
    
    // تأكد من إرسال معرف المنتج بالشكل الصحيح
    final requestBody = jsonEncode({"productId": productId});
    debugPrint('Request body: $requestBody');
    
    final response = await _client.post(
      uri,
      headers: Cache.instance.sessionToken!.toAuthHeaders,
      body: requestBody,
    );
    
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: "${response.body}"');
    
    await NetworkUtils.renewToken(response);
    
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.body.isNotEmpty) {
        try {
          final payload = jsonDecode(response.body) as DataMap;
          final errorResponse = ErrorResponse.fromMap(payload);
          throw ServerException(
            message: errorResponse.errorMessage,
            statusCode: response.statusCode,
          );
        } catch (jsonError) {
          debugPrint('Error parsing JSON: $jsonError');
          throw ServerException(
            message: "Failed to parse server response",
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ServerException(
          message: "Server returned an empty response",
          statusCode: response.statusCode,
        );
      }
    }
  } on ServerException {
    rethrow;
  } catch (e, s) {
    debugPrint('Exception: ${e.toString()}');
    debugPrintStack(stackTrace: s);
    throw const ServerException(
      message: "Error Occurred: It's not your fault, it's ours",
      statusCode: 500,
    );
  }
}

  @override
  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userWishlistEndpoint(userId)}/$productId',
      );

      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 204) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        debugPrint(response.body);
        debugPrintStack();
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
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

String _userWishlistEndpoint(String userId) {
  return "users/$userId/wishlist"; // إزالة `/` الزائدة
}

}
