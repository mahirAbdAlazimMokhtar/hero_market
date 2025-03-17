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
  @override
  Future<List<WishlistProductModel>> getWishlist(String userId) async {
    try {
      // Validate userId
      if (userId == ":id" || userId.isEmpty) {
        debugPrint('ERROR: Invalid userId in getWishlist: "$userId"');
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
  
      final uri = Uri.https(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}/users/$userId/wishlist',
      );
  
      debugPrint('Getting wishlist: $uri');
  
      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      
      debugPrint('Response status: ${response.statusCode}');
      
      await NetworkUtils.renewToken(response);
      
      if (response.statusCode != 200) {
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
      
      final payload = jsonDecode(response.body);
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
      debugPrint('Exception: ${e.toString()}');
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
    // Validate userId
    if (userId == ":id" || userId.isEmpty) {
      debugPrint('ERROR: Invalid userId: "$userId"');
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

    // Validate productId
    if (productId.isEmpty) {
      debugPrint('ERROR: Invalid productId: "$productId"');
      throw const ServerException(
        message: "Product ID is required.",
        statusCode: 400,
      );
    }

    // Build URI
    final uri = Uri.https(
      NetworkConstants.authority,
      '${NetworkConstants.apiUrl}/users/$userId/wishlist',
    );

    debugPrint('Adding to wishlist: $uri');

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

    // Handle 409 Conflict (product already in wishlist) as success
    if (response.statusCode == 409) {
      debugPrint('Product already in wishlist - treating as success');
      return; // Return successfully
    }

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
  @override
  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      // Validate userId
      if (userId == ":id" || userId.isEmpty) {
        debugPrint('ERROR: Invalid userId: "$userId"');
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

      // Validate productId
      if (productId.isEmpty) {
        debugPrint('ERROR: Invalid productId: "$productId"');
        throw const ServerException(
          message: "Product ID is required.",
          statusCode: 400,
        );
      }

      // Build URI - use the same format as addToWishlist
      final uri = Uri.https(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}/users/$userId/wishlist/$productId',
      );

      debugPrint('Removing from wishlist: $uri');

      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: "${response.body}"');

      await NetworkUtils.renewToken(response);

      // Handle 404 Not Found (product not in wishlist) as success
      if (response.statusCode == 404) {
        debugPrint('Product not found in wishlist - treating as success');
        return; // Return successfully
      }

      if (response.statusCode != 200 && response.statusCode != 204) {
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

String _userWishlistEndpoint(String userId) {
    // Make sure this matches the format used in addToWishlist and removeFromWishlist
    return "/users/$userId/wishlist";
  }
}
