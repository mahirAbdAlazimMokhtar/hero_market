import 'package:dartz/dartz.dart';
import 'package:hero_market/core/errors/exceptions.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/data/datasources/product_remote_data_src.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/domain/entities/review.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

import '../../../../../core/errors/failures.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductModelsRemoteDataSrc _remoteDataSrc;

  ProductRepoImpl(this._remoteDataSrc);
  @override
  ResultFuture<List<ProductCategory>> getCategories() async {
    try {
      final result = await _remoteDataSrc.getCategories();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<ProductCategory> getCategory(String categoryId) async {
    try {
      final result = await _remoteDataSrc.getCategory(categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> getNewArrivals(
      {required int page, String? categoryId}) async {
    try {
      final result = await _remoteDataSrc.getNewArrivals(
          page: page, categoryId: categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> getPopular(
      {required int page, String? categoryId}) async {
    try {
      final result =
          await _remoteDataSrc.getPopular(page: page, categoryId: categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<Product> getProduct(String productId) async {
    try {
      final result = await _remoteDataSrc.getProduct(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Review>> getProductReviews(
      {required String productId, required int page}) async {
    try {
      final result = await _remoteDataSrc.getProductReviews(
          productId: productId, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> getProducts(int page) async {
    try {
      final result = await _remoteDataSrc.getProducts(page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> getProductsByCategory(
      {required String categoryId, required int page}) async {
    try {
      final result = await _remoteDataSrc.getProductsByCategory(
          categoryId: categoryId, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<void> leaveReview(
      {required String productId,
      required String comment,
      required String userId,
      required double rating}) async {
    try {
      final result = await _remoteDataSrc.leaveReview(
          productId: productId,
          comment: comment,
          userId: userId,
          rating: rating);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> searchAllProducts(
      {required String query, required int page}) async {
    try {
      final result =
          await _remoteDataSrc.searchAllProducts(query: query, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> searchByCategory(
      {required String categoryId,
      required String query,
      required int page}) async {
    try {
      final result = await _remoteDataSrc.searchByCategory(
          categoryId: categoryId, query: query, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<List<Product>> searchByCategoryAndGenderAgeCategory(
      {required String categoryId,
      required String genderAgeCategory,
      required int page,
      required String query}) async {
    try {
      final result = await _remoteDataSrc.searchByCategoryAndGenderAgeCategory(
          categoryId: categoryId,
          genderAgeCategory: genderAgeCategory,
          page: page,
          query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
}
