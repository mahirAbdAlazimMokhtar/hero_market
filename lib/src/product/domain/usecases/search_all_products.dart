import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';

import '../entities/product.dart';
import '../repositories/product_repo.dart';

class SearchAllProducts
    extends UsecasesWithParams<List<Product>, SearchAllProductsParams> {
  final ProductRepo productRepo;
  SearchAllProducts(this.productRepo);

  @override
  ResultFuture<List<Product>> call(SearchAllProductsParams params) {
    return productRepo.searchAllProducts(
        query: params.query, page: params.page);
  }
}

class SearchAllProductsParams extends Equatable {
  final String categoryId;
  final String query;
  final int page;

  const SearchAllProductsParams({
    required this.categoryId,
    required this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [categoryId, query, page];
}
