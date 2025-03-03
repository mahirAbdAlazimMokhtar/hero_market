import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hero_market/core/common/singletons/cache.dart';
import 'package:hero_market/core/extensions/string_extensions.dart';
import 'package:hero_market/core/utils/constants/network_constants.dart';
import 'package:hero_market/core/utils/network_utils.dart';
import 'package:hero_market/src/product/data/models/category_model.dart';
import 'package:hero_market/src/product/data/models/review_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/error_response.dart';
import '../../../../core/utils/typedefs.dart';
import '../models/product_models.dart';

abstract interface class ProductModelsRemoteDataSrc {
  const ProductModelsRemoteDataSrc();
  Future<List<ProductModel>> getProducts(int page);
  Future<ProductModel> getProduct(String productId);

  Future<List<ProductModel>> getProductsByCategory(
      {required String categoryId, required int page});

  Future<List<ProductModel>> getNewArrivals(
      {required int page, String? categoryId});

  Future<List<ProductModel>> getPopular(
      {required int page, String? categoryId});

  Future<List<ProductModel>> searchAllProducts(
      {required String query, required int page});

  Future<List<ProductModel>> searchByCategory({
    required String categoryId,
    required String query,
    required int page,
  });

  //searchByCategoryAndGenderAgeCategory , getCategories , leaveReview

  Future<List<ProductCategoryModel>> getCategories();
  Future<ProductCategoryModel> getCategory(String categoryId);
  Future<List<ProductModel>> searchByCategoryAndGenderAgeCategory(
      {required String categoryId,
      required String genderAgeCategory,
      required int page,
      required String query});

  Future<void> leaveReview({
    required String productId,
    required String userId,
    required String comment,
    required double rating,
  });

  //getReviews , getReview

  Future<List<ReviewModel>> getProductReviews({
    required String productId,
    required int page,
  });
}

// ignore: constant_identifier_names
const GET_PRODUCTS_ENDPOINT = '/products';
const SEARCH_PRODUCTS_ENDPOINT = '$GET_PRODUCTS_ENDPOINT/search';
const GET_CATEGORIES_ENDPOINT = '/categories';
const GET_PRODUCT_REVIEWS_ENDPOINT = '/reviews';


class ProductRemoteDataSrcImpl implements ProductModelsRemoteDataSrc {
  const ProductRemoteDataSrcImpl(this._client);

  final http.Client _client;

@override
Future<List<ProductCategoryModel>> getCategories() async {
  try {
    final uri = Uri.parse(
      '${NetworkConstants.baseUrl}$GET_CATEGORIES_ENDPOINT',
    );

    final response = await _client.get(
      uri,
      headers: Cache.instance.sessionToken!.toAuthHeaders,
    );

    final payload = jsonDecode(response.body) as Map<String, dynamic>;

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

    // استخراج القائمة من الحقل "products" (أو الحقل المناسب)
    final List<dynamic> categoriesList = payload['categories'] ?? [];

    // تحويل القائمة إلى List<ProductCategoryModel>
    return categoriesList
        .cast<DataMap>()
        .map((category) => ProductCategoryModel.fromMap(category))
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
  Future<ProductCategoryModel> getCategory(String categoryId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$GET_CATEGORIES_ENDPOINT/$categoryId',
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
      return ProductCategoryModel.fromMap(payload);
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
Future<List<ProductModel>> getNewArrivals({
  required int page,
  String? categoryId,
}) async {
  try {
    const endpoint = '${NetworkConstants.apiUrl}$GET_PRODUCTS_ENDPOINT';

    final queryParams = {
      'criteria': 'newArrivals',
      if (categoryId != null) 'category': categoryId,
      'page': '$page',
    };

    final uri = NetworkConstants.baseUrl.startsWith('https')
        ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
        : Uri.http(NetworkConstants.authority, endpoint, queryParams);

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

    // استخراج القائمة من الحقل "products"
    final List<dynamic> productsList = payload['products'] ?? [];

    // تحويل القائمة إلى List<ProductModel>
    return productsList
        .cast<DataMap>()
        .map((product) => ProductModel.fromMap(product))
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
Future<List<ProductModel>> getPopular({
  required int page,
  String? categoryId,
}) async {
  try {
    const endpoint = '${NetworkConstants.apiUrl}$GET_PRODUCTS_ENDPOINT';

    final queryParams = {
      'criteria': 'popular',
      if (categoryId != null) 'category': categoryId,
      'page': '$page',
    };

    final uri = NetworkConstants.baseUrl.startsWith('https')
        ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
        : Uri.http(NetworkConstants.authority, endpoint, queryParams);

    final response = await _client.get(
      uri,
      headers: Cache.instance.sessionToken!.toAuthHeaders,
    );
    
    final dynamic rawPayload = jsonDecode(response.body);
    await NetworkUtils.renewToken(response);
    
    if (response.statusCode != 200) {
      final errorResponse = ErrorResponse.fromMap(rawPayload as DataMap);
      debugPrint(response.body);
      debugPrintStack();
      throw ServerException(
        message: errorResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }

    // تحقق من نوع البيانات الواردة
    List<dynamic> productsList;
    if (rawPayload is Map<String, dynamic>) {
      // إذا كانت البيانات على شكل خريطة، استخرج قائمة المنتجات
      productsList = rawPayload['products'] ?? [];
    } else if (rawPayload is List<dynamic>) {
      // إذا كانت البيانات مباشرة على شكل قائمة
      productsList = rawPayload;
    } else {
      // إذا كان الشكل غير معروف، استخدم قائمة فارغة
      productsList = [];
    }

    //debugPrint("Products data: $productsList");
    
    return productsList
        .cast<DataMap>()
        .map((product) => ProductModel.fromMap(product))
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
  Future<ProductModel> getProduct(String productId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$productId',
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
      return ProductModel.fromMap(payload);
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
  Future<List<ReviewModel>> getProductReviews({
    required String productId,
    required int page,
  }) async {
    try {
      final endpoint = '${NetworkConstants.apiUrl}$GET_PRODUCTS_ENDPOINT'
          '/$productId$GET_PRODUCT_REVIEWS_ENDPOINT';

      final queryParams = {'page': '$page'};
      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
          : Uri.http(NetworkConstants.authority, endpoint, queryParams);

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
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
          .map((review) => ReviewModel.fromMap(review))
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
  Future<List<ProductModel>> getProducts(int page) async {
    try {
      const endpoint = '${NetworkConstants.apiUrl}$GET_PRODUCTS_ENDPOINT';

      final queryParams = {'page': '$page'};
      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
          : Uri.http(NetworkConstants.authority, endpoint, queryParams);

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
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
          .map((product) => ProductModel.fromMap(product))
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
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    required int page,
  }) async {
    try {
      const endpoint = '${NetworkConstants.apiUrl}$GET_PRODUCTS_ENDPOINT';

      final queryParams = {'category': categoryId, 'page': '$page'};
      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
          : Uri.http(NetworkConstants.authority, endpoint, queryParams);

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
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
          .map((product) => ProductModel.fromMap(product))
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
  Future<List<ProductModel>> searchAllProducts({
    required String query,
    required int page,
  }) async {
    try {
      const endpoint = '${NetworkConstants.apiUrl}$SEARCH_PRODUCTS_ENDPOINT';

      final queryParams = {'q': query, 'page': '$page'};
      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
          : Uri.http(NetworkConstants.authority, endpoint, queryParams);

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
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
          .map((product) => ProductModel.fromMap(product))
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
  Future<List<ProductModel>> searchByCategory({
    required String query,
    required String categoryId,
    required int page,
  }) async {
    try {
      const endpoint = '${NetworkConstants.apiUrl}$SEARCH_PRODUCTS_ENDPOINT';

      final queryParams = {'q': query, 'category': categoryId, 'page': '$page'};
      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
          : Uri.http(NetworkConstants.authority, endpoint, queryParams);

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
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
          .map((product) => ProductModel.fromMap(product))
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
Future<List<ProductModel>> searchByCategoryAndGenderAgeCategory({
  required String query,
  required String categoryId,
  required String genderAgeCategory,
  required int page,
}) async {
  try {
    const endpoint = '${NetworkConstants.apiUrl}$SEARCH_PRODUCTS_ENDPOINT';

    final queryParams = {
      'q': query,
      'category': categoryId,
      'genderAgeCategory': genderAgeCategory,
      'page': '$page'
    };

    final uri = NetworkConstants.baseUrl.startsWith('https')
        ? Uri.https(NetworkConstants.authority, endpoint, queryParams)
        : Uri.http(NetworkConstants.authority, endpoint, queryParams);

    print("Requesting: $uri");
    final response = await _client.get(
      uri,
      headers: Cache.instance.sessionToken!.toAuthHeaders,
    );

    print("Response Body: ${response.body}");
    final payload = jsonDecode(response.body);
    await NetworkUtils.renewToken(response);

    if (response.statusCode != 200) {
      final errorResponse = ErrorResponse.fromMap(payload as DataMap);
      debugPrint(response.body);
      debugPrintStack();
      throw ServerException(
        message: errorResponse.errorMessage,
        statusCode: response.statusCode,
      );
    }

    if (payload is! List) {
      throw ServerException(
        message: "Invalid response format from server",
        statusCode: response.statusCode,
      );
    }

    return payload
        .cast<DataMap>()
        .map((product) => ProductModel.fromMap(product))
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
  Future<void> leaveReview({
    required String productId,
    required String userId,
    required String comment,
    required double rating,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT'
        '/$productId$GET_PRODUCT_REVIEWS_ENDPOINT',
      );

      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode({
          'user': userId,
          'comment': comment,
          'rating': rating,
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
}

