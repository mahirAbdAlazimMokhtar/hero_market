import 'dart:convert';
import 'dart:ui';


import 'package:flutter/foundation.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/extensions/color_extension.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/constants/network_constants.dart';
import 'package:hero_market/core/utils/error_response.dart';
import 'package:hero_market/core/utils/network_utils.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/cart/data/model/cart_product_model.dart';
import 'package:hero_market/src/cart/domain/entities/cart_product.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSrc {
  Future<List<CartProductModel>> getCart(String userId);

  Future<int> getCartCount(String userId);

  Future<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  });

  Future<void> addToCart({
    required String userId,
    required CartProduct cartProduct,
  });

  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  });

  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  });

  Future<String> initiateCheckout({
    required String theme,
    required List<CartProduct> cartItems,
  });
}

class CartRemoteDataSrcImpl implements CartRemoteDataSrc {
  const CartRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<CartProductModel>> getCart(String userId) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}',
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
            (cartProduct) => CartProductModel.fromMap(cartProduct),
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
  Future<int> getCartCount(String userId) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/count',
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
      return (payload as num).toInt();
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
  Future<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/$cartProductId',
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        debugPrint(response.body);
        debugPrintStack();
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return CartProductModel.fromMap(payload);
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
  Future<void> addToCart({
    required String userId,
    required CartProduct cartProduct,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}',
      );

      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode({
          'productId': cartProduct.productId,
          'quantity': cartProduct.quantity,
          if (cartProduct.selectedSize != null)
            'selectedSize': cartProduct.selectedSize,
          if (cartProduct.selectedColor != null)
            'selectedColor': cartProduct.selectedColor!.hex,
        }),
      );
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
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

  @override
  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/$cartProductId',
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

  @override
  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/$cartProductId',
      );

      final response = await _client.put(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode({'quantity': newQuantity}),
      );
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
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

  String _userCartEndpoint(String userId) => '/users/$userId/cart';

  @override
  Future<String> initiateCheckout({
    required String theme,
    required List<CartProduct> cartItems,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}/checkout',
        {'theme': theme},
      );

      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode({
          'cartItems': cartItems.map((cartProduct) {
            return {
              "name": cartProduct.productName,
              "images": [cartProduct.productImage],
              "price": cartProduct.productPrice,
              "productId": cartProduct.productId,
              "cartProductId": cartProduct.id,
              "quantity": cartProduct.quantity,
              if (cartProduct case CartProduct(:final selectedSize))
                "selectedSize": selectedSize,
              if (cartProduct case CartProduct(:final Color selectedColor))
                "selectedColor": selectedColor.hex
            };
          }).toList(),
        }),
      );
      await NetworkUtils.renewToken(response);
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        debugPrint(response.body);
        debugPrintStack();
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return payload['url'] as String;
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
