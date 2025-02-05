import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';

import '../entities/category.dart';
import '../entities/review.dart';

abstract interface class ProductRepo {
  ResultFuture<List<Product>> getProducts(int page);
  ResultFuture<Product> getProduct(String productId);

  ResultFuture<List<Product>> getProductsByCategory(
      {required String categoryId, required int page});

  //getNewARrivals ,getPopular, searchAllProducts, searchByCategory

  ResultFuture<List<Product>> getNewArrivals(
      {required int page, String? categoryId});

  ResultFuture<List<Product>> getPopular(
      {required int page, String? categoryId});

  ResultFuture<List<Product>> searchAllProducts(
      {required String query, required int page});

  ResultFuture<List<Product>> searchByCategory({
    required String categoryId,
    required String query,
    required int page,
  });

  //searchByCategoryAndGenderAgeCategory , getCategories , leaveReview

  ResultFuture<List<ProductCategory>> getCategories();
  ResultFuture<ProductCategory> getCategory(String categoryId);
  ResultFuture<List<Product>> searchByCategoryAndGenderAgeCategory(
      {required String categoryId,
      required String genderAgeCategory,
      required int page,
      required String query});

  ResultFuture<bool> leaveReview({
    required String productId,
    required String comment,
    required String userId,
    required double rating,
  });

  //getReviews , getReview

  ResultFuture<List<Review>> getProductReviews({
    required String productId,
    required int page,
  });
}
