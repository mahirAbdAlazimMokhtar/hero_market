import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_market/src/product/domain/entities/category.dart';
import 'package:hero_market/src/product/domain/usecases/get_categories.dart';
import 'package:hero_market/src/product/domain/usecases/get_category.dart';
import 'package:hero_market/src/product/domain/usecases/get_new_arrivals.dart';
import 'package:hero_market/src/product/domain/usecases/get_popular.dart';
import 'package:hero_market/src/product/domain/usecases/get_product.dart';
import 'package:hero_market/src/product/domain/usecases/get_product_reviews.dart';
import 'package:hero_market/src/product/domain/usecases/get_products.dart';
import 'package:hero_market/src/product/domain/usecases/get_products_by_category.dart';
import 'package:hero_market/src/product/domain/usecases/leave_review.dart';
import 'package:hero_market/src/product/domain/usecases/search_all_products.dart';
import 'package:hero_market/src/product/domain/usecases/search_by_category.dart';
import 'package:hero_market/src/product/domain/usecases/search_by_category_and_gender_age_category.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/review.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required GetCategories getCategories,
    required GetCategory getCategory,
    required GetPopular getPopular,
    required GetProductReviews getProductReviews,
    required GetProduct getProduct,
    required GetProductsByCategory getProductsByCategory,
    required GetProducts getProducts,
    required LeaveReview leaveReview,
    required SearchAllProducts searchAllProducts,
    required SearchByCategory searchByCategory,
    required SearchByCategoryAndGenderAgeCategory
        searchByCategoryAndGenderAgeCategory,
    required GetNewArrivals getNewArrivals,
  })  : _getCategories = getCategories,
        _getCategory = getCategory,
        _getPopular = getPopular,
        _getProductReviews = getProductReviews,
        _getProduct = getProduct,
        _getProductsByCategory = getProductsByCategory,
        _getProducts = getProducts,
        _leaveReview = leaveReview,
        _searchAllProducts = searchAllProducts,
        _searchByCategory = searchByCategory,
        _searchByCategoryAndGenderAgeCategory =
            searchByCategoryAndGenderAgeCategory,
        _getNewArrivals = getNewArrivals,
        super(ProductInitial());

  final GetCategories _getCategories;
  final GetCategory _getCategory;
  final GetNewArrivals _getNewArrivals;
  final GetPopular _getPopular;
  final GetProductReviews _getProductReviews;
  final GetProduct _getProduct;
  final GetProductsByCategory _getProductsByCategory;
  final GetProducts _getProducts;
  final LeaveReview _leaveReview;
  final SearchAllProducts _searchAllProducts;
  final SearchByCategory _searchByCategory;
  final SearchByCategoryAndGenderAgeCategory
      _searchByCategoryAndGenderAgeCategory;

  Future<void> getCategories() async {
    emit(const FetchingCategories());
    final result = await _getCategories();
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (categories) {
      emit(CategoriesFetched(categories));
    });
  }

  Future<void> getCategory(String categoryId) async {
    emit(const FetchingCategory());
    final result = await _getCategory(GetCategoryParams(categoryId));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (category) {
      emit(CategoryFetched(category));
    });
  }

  Future<void> getNewArrivals({
    required int page,
    String? categoryId,
  }) async {
    emit(const FetchingProducts());
    final result = await _getNewArrivals(
        GetNewArrivalsPrams(page: page, categoryId: categoryId));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) {
      emit(ProductsFetched(products));
    });
  }

  Future<void> getPopular({
    required int page,
    String? categoryId,
  }) async {
    emit(FetchingProducts());
    final result =
        await _getPopular(GetPopularParams(page: page, categoryId: categoryId));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }

  Future<void> getProductReviews({
    required String productId,
    required int page,
  }) async {
    emit(FetchingReviews());
    final result = await _getProductReviews(
        GetProductReviewsParams(productId: productId, page: page));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (reviews) => emit(ReviewsFetched(reviews)));
  }

  Future<void> getProduct(String productId) async {
    emit(FetchingProduct());
    final result = await _getProduct(GetProductParams(productId: productId));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (product) => emit(ProductFetched(product)));
  }

  Future<void> getProductsByCategory({
    required String categoryId,
    required int page,
  }) async {
    emit(FetchingProducts());
    final result = await _getProductsByCategory(
        GetProductsByCategoryParams(categoryId: categoryId, page: page));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }

  Future<void> getProducts({
    required int page,
  }) async {
    emit(FetchingProducts());
    final result = await _getProducts(page);
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }

  Future<void> leaveReview({
    required String productId,
    required int rating,
    required String comment,
    required String userId,
  }) async {
    emit(Reviewing());
    final result = await _leaveReview(LeaveReviewParams(
        productId: productId,
        comment: comment,
        userId: userId,
        rating: rating.toString()));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (_) => emit(const ProductReviewed()));
  }

  Future<void> searchAllProducts({
    required String query,
    required int page,
  }) async {
    emit(SearchingProduct());
    final result = await _searchAllProducts(SearchAllProductsParams(
        query: query, page: page));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }

  Future<void> searchByCategory({
    required String query,
    required int page,
    required String categoryId,
  }) async {
    emit(SearchingProduct());
    final result = await _searchByCategory(SearchByCategoryParams(
        query: query, page: page, categoryId: categoryId));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }

  Future<void> searchByCategoryAndGenderAgeCategory({
    required String query,
    required int page,
    required String categoryId,
    required String genderAgeCategory,
  }) async {
    emit(SearchingProduct());
    final result = await _searchByCategoryAndGenderAgeCategory(
        SearchByCategoryAndGenderAgeCategoryParams(
            query: query,
            page: page,
            categoryId: categoryId,
            genderAgeCategory: genderAgeCategory));
    result.fold((failure) => emit(ProductError(failure.errorMessage)),
        (products) => emit(ProductsFetched(products)));
  }
}
