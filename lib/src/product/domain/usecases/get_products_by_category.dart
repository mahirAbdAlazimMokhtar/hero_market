import 'package:equatable/equatable.dart';
import 'package:hero_market/core/usecase/usecase.dart';
import 'package:hero_market/core/utils/typedefs.dart';
import 'package:hero_market/src/product/domain/entities/product.dart';
import 'package:hero_market/src/product/domain/repositories/product_repo.dart';

class GetProductsByCategory
    extends UsecasesWithParams<List<Product>, GetProductsByCategoryParams> {
  const GetProductsByCategory(this._productRepo);
  final ProductRepo _productRepo;

  @override
  ResultFuture<List<Product>> call(GetProductsByCategoryParams params) {
    return _productRepo.getProductsByCategory(
        categoryId: params.categoryId, page: params.page);
  }
}

class GetProductsByCategoryParams extends Equatable {
  const GetProductsByCategoryParams({
    required this.categoryId,
    required this.page,
  });
  final String categoryId;
  final int page;

  @override
  List<Object?> get props => [categoryId, page];
}
