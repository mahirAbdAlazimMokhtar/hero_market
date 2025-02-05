import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';

import '../repositories/product_repo.dart';

class SearchByCategory
    extends UsecasesWithParams<List<Product>, SearchByCategoryParams> {
  final ProductRepo productRepo;
  const SearchByCategory(this.productRepo);

  @override
  ResultFuture<List<Product>> call(SearchByCategoryParams params) {
    return productRepo.searchByCategory(
        categoryId: params.categoryId, query: params.query, page: params.page);
  }
}

class SearchByCategoryParams extends Equatable {
  final String categoryId;
  final String query;
  final int page;

  const SearchByCategoryParams(
      {required this.categoryId, required this.query, required this.page});

  @override
  List<Object?> get props => [categoryId, query, page];
}
