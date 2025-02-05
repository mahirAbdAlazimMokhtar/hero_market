import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../entities/product.dart';
import '../repositories/product_repo.dart';

class SearchByCategoryAndGenderAgeCategory extends UsecasesWithParams<
    List<Product>, SearchByCategoryAndGenderAgeCategoryParams> {
  final ProductRepo _productRepo;

  SearchByCategoryAndGenderAgeCategory(this._productRepo);

  @override
  ResultFuture<List<Product>> call(
      SearchByCategoryAndGenderAgeCategoryParams params) {
    return _productRepo.searchByCategoryAndGenderAgeCategory(
        categoryId: params.categoryId,
        genderAgeCategory: params.genderAgeCategory,
        page: params.page,
        query: params.query);
  }
}

class SearchByCategoryAndGenderAgeCategoryParams extends Equatable {
  final String categoryId;
  final String genderAgeCategory;
  final int page;
  final String query;

  const SearchByCategoryAndGenderAgeCategoryParams(
      {required this.categoryId,
      required this.genderAgeCategory,
      required this.page,
      required this.query});

  @override
  List<Object?> get props => [
        categoryId,
        genderAgeCategory,
        page,
        query,
      ];
}
